"""Validation gate for the qompassai/PathFinders repository.

PathFinders is a teaching program: numbered Lessons (each with a
README and config files) and a Youth track whose project is a
pygame Space Invaders game (Youth/SpaceInvaders/main.py plus its
Jupyter notebooks). These tests validate that material: lesson
structure, notebook well-formedness, the game's one pure piece of
logic (its collision test, extracted by AST because main.py runs
its game loop at import), the assets the code references, and the
shell scripts.

Three .py files are accounted for explicitly rather than silently
excluded: space.py and spacetest.py are notebook exports full of
Jupyter '!' shell escapes (valid only cell-wise), and test3.py is
a saved LLM chat transcript. A test pins that exact set — a new
unparseable .py, or fixing one of the three, turns this suite red
until the accounting is updated.

Run: python3 -m pytest tests/ -q
"""

from __future__ import annotations

import ast
import json
import math
import subprocess
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent
GAME_DIR = REPO_ROOT / 'Youth' / 'SpaceInvaders'
SUBPROCESS_TIMEOUT_S = 30

# .py files that are not standalone Python, with their reasons
# (see module docstring). Paths are repo-relative.
KNOWN_NON_STANDALONE_PY = {
    'Youth/SpaceInvaders/space.py',
    'Youth/SpaceInvaders/spacetest.py',
    'Youth/SpaceInvaders/test3.py',
}

SHELL_SCRIPTS = [
    'Lessons/Level 9/build_darwin.sh',
    'Lessons/Level 9/granite.sh',
    'Youth/SpaceInvaders/jupyter.sh',
]


def _validate_notebook(data: object) -> list[str]:
    """Contract for a Jupyter notebook (nbformat 4)."""
    problems: list[str] = []
    if not isinstance(data, dict):
        return ['notebook: top level is not an object']
    if data.get('nbformat') != 4:
        problems.append(f'notebook: nbformat is {data.get("nbformat")!r}, want 4')
    cells = data.get('cells')
    if not isinstance(cells, list):
        problems.append('notebook: cells missing or not a list')
        return problems
    for index, cell in enumerate(cells):
        if not isinstance(cell, dict) or cell.get('cell_type') not in {
            'code',
            'markdown',
            'raw',
        }:
            problems.append(f'notebook: cell {index} lacks a valid cell_type')
        elif not isinstance(cell.get('source'), (str, list)):
            problems.append(f'notebook: cell {index} source is not text')
    return problems


def _load_collision() -> object:
    """Extract main.py's pure isCollision function without importing it.

    main.py starts its game loop at module level, so importing it
    would open a window and loop forever; parsing its AST and
    compiling only the one pure function is the hermetic route.
    """
    tree = ast.parse((GAME_DIR / 'main.py').read_text(encoding='utf-8'))
    for node in tree.body:
        if isinstance(node, ast.FunctionDef) and node.name == 'isCollision':
            namespace: dict[str, object] = {'math': math}
            exec(
                compile(ast.Module(body=[node], type_ignores=[]), 'main.py', 'exec'),
                namespace,
            )
            return namespace['isCollision']
    raise AssertionError('isCollision not found in main.py')


# --- Validation ---


def test_lesson_directories_have_readmes() -> None:
    lessons = REPO_ROOT / 'Lessons'
    level_dirs = [
        path
        for path in lessons.iterdir()
        if path.is_dir() and path.name.lower().startswith('level')
    ]
    assert len(level_dirs) >= 8, 'expected at least 8 lesson levels'
    for path in level_dirs:
        assert (path / 'README.md').exists(), f'{path} has no README.md'


def test_notebooks_are_well_formed() -> None:
    notebooks = sorted(
        path
        for path in REPO_ROOT.glob('**/*.ipynb')
        if '.virtual_documents' not in path.parts
    )
    assert len(notebooks) >= 4, 'expected the SpaceInvaders notebooks and checkpoints'
    for path in notebooks:
        data = json.loads(path.read_text(encoding='utf-8'))
        assert _validate_notebook(data) == [], path


def test_virtual_documents_accounting_is_exact() -> None:
    """The .virtual_documents/*.ipynb files are not notebooks.

    They are Python renderings produced by an editor's virtual
    document feature, carrying an .ipynb extension they do not
    satisfy (neither parses as JSON). Pin the exact set so a new
    mislabeled artifact — or cleaning these up — is a visible,
    deliberate change to this accounting.
    """
    virtual = sorted((GAME_DIR / '.virtual_documents').glob('*.ipynb'))
    assert [path.name for path in virtual] == ['space.ipynb', 'spaceinvaders.ipynb']
    for path in virtual:
        try:
            json.loads(path.read_text(encoding='utf-8'))
        except json.JSONDecodeError:
            continue
        raise AssertionError(f'{path} now parses as JSON — update this accounting')


def test_game_python_parses_and_assets_exist() -> None:
    source = (GAME_DIR / 'main.py').read_text(encoding='utf-8')
    ast.parse(source)  # raises SyntaxError if the game stops parsing
    tree = ast.parse(source)
    referenced = {
        node.value
        for node in ast.walk(tree)
        if isinstance(node, ast.Constant)
        and isinstance(node.value, str)
        and node.value.endswith(('.png', '.wav'))
    }
    assert referenced, 'main.py should reference sprite/sound assets'
    for name in referenced:
        assert (GAME_DIR / name).exists(), f'referenced asset missing: {name}'


def test_collision_geometry() -> None:
    is_collision = _load_collision()
    assert callable(is_collision)
    # contact and near misses collide; the radius is 27 px
    assert is_collision(100, 100, 100, 100) is True
    assert is_collision(100, 100, 126, 100) is True
    assert is_collision(100, 100, 100, 74) is True
    assert is_collision(100, 100, 118, 118) is True  # ~25.5 px diagonal


def test_shell_scripts_parse() -> None:
    for script in SHELL_SCRIPTS:
        result = subprocess.run(
            ['bash', '-n', script],
            cwd=REPO_ROOT,
            capture_output=True,
            text=True,
            timeout=SUBPROCESS_TIMEOUT_S,
            check=False,
        )
        assert result.returncode == 0, f'{script}: {result.stderr}'


def test_non_standalone_python_accounting_is_exact() -> None:
    failures = set()
    for path in sorted(REPO_ROOT.glob('**/*.py')):
        try:
            ast.parse(path.read_text(encoding='utf-8'))
        except SyntaxError:
            failures.add(path.relative_to(REPO_ROOT).as_posix())
    assert failures == KNOWN_NON_STANDALONE_PY


# --- Adversarial ---


def test_collision_boundary_is_strict() -> None:
    is_collision = _load_collision()
    assert callable(is_collision)
    # exactly at the radius is NOT a collision (comparison is <)
    assert is_collision(100, 100, 127, 100) is False
    assert is_collision(100, 100, 400, 400) is False
    # negative coordinates are just geometry, not an error
    assert is_collision(-50, -50, -50, -30) is True


def test_notebook_wrong_version_is_rejected() -> None:
    data = json.loads((GAME_DIR / 'space.ipynb').read_text(encoding='utf-8'))
    data['nbformat'] = 3
    assert _validate_notebook(data) != []


def test_notebook_cell_without_type_is_rejected() -> None:
    data = json.loads((GAME_DIR / 'space.ipynb').read_text(encoding='utf-8'))
    data['cells'] = [{'source': 'print(1)'}]
    assert _validate_notebook(data) != []


def test_notebook_non_mapping_is_rejected() -> None:
    assert _validate_notebook(['not', 'a', 'notebook']) != []
