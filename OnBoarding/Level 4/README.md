# Linking Pass, GPG, and Huggingface

- Clone this repo locally and make sure you're in it by using `pwd` and `ls -a` to orient yourself

- Install pass, aka an open-source password manager linked to your gpg/ssh keys.
- **pass is a system binary, aka a program that can be used `anywhere` on your computer**

## MacOS

```MacOS
brew install pass
```

## Arch / WSL2 Arch

```bash 
sudo pacman -S pass
```

## Ubuntu/Debian | WSL2 Ubuntu/Debian

```bash
sudo apt install pass
```

- Initialize (init) pass with your GPG key ID (use the ID of your signing subkey):

## MacOS | Linux | MSFT WSL2 

```bash
pass init "0x2345678901ABCDEF"
```

- Copy your Huggingface API token and then paste it into pass. 
- **You will need to do this twice**.

## You will **NOT** see any characters when you paste your token into pass. This is normal.##

## MacOS | WSL2 | Linux

```bash
pass insert hf
```

- Verify that your huggingface token is stored correctly in pass, which can be run anywhere.

## MacOS | WSL2 | Linux

```bash
pass show hf
```

- Copy the .hfrc to your home directory. The one with the `~`- most commonly this is what it means when you see `"add to PATH"`

## MacOS | WSL2 | Linux

```bash
cp -r .hfrc ~
```

- z/cd into ~ and source your .bashrc/zshrc. This "loads" all of your configurations.
- Also make a new directory for HF models and datasets based on the .hfrc before your source .bashrc/.zshrc

## MacOS

```bash 
mkdir -p HF/models
mkdir -p HF/datasets
. ~/.zshrc 
```

## Linux | MSFT WSL2

```bash
mkdir -p HF/models
mkdir -p HF/datasets
. ~/.bashrc
```
- Use the huggingface-cli to download the [Qompass R3 model](https://huggingface.co/qompass/r3)

- **Make sure you install safetensors and transformers libraries installed before you do.**

## MacOS | WSL2 | Linux

- Type `pass show hf` to see your HF token and copy it to paste when prompted by the huggingface cli.

```bash
pip install -U safetensors transformers
huggingface-cli login
```

- If you haven't already, read the huggingface model card for qompass/r3, look up any unfamiliar terms.

- Use the huggingface cli to download the model weights.

## MacOS | WSL2 | Linux

```bash
huggingface-cli download qompass/r3
```

- This will take a good amount of time to download. Find the files directory on the model card if you haven't already.

## Download your first dataset

- Read the dataset card for the[Solar Irradiance Dataset 2021](https://huggingface.co/datasets/surya-ravindra/solar_irradiance_dataset_2021).
- Note the modalities (data type), libraries (datasets, dask, croissant, polars) and the the lack of a LICENSE.
- Use the huggingface cli to download the dataset files:

## MacOS | Linux | MSFT WSL2

```bash
huggingface-cli download surya-ravindra/solar_irradiance_dataset_2021 --repo-type dataset
```

- z/cd into ~ and then into your new HF/datset directory

#
```bash
z
z /HF/dataset
```
- cd/z into the surya-ravindra/solar_irradiance_dataset_2021 directory

```
z datasets--surya-ravindra--solar_irradiance_dataset_2021/snapshots/3c06b4ec435099637eadd2b0c98d57f3453c110a/data
```

- You'll see two parquet files. That's the solar data set.

## MacOS | Linux | MSFT WSL2

```
train-00000-of-00002.parquet  train-00001-of-00002.parquet
```

## Convert the dataset into a readable format

**Neovim itself doesn’t have direct support for reading Parquet files, so we'll convert the data parquet files into Comma-separate-values (CSV)
via the python pandas library and Apache Arrow.**


```bash
pip install pandas pyarrow croissant polars datasets dask
```

- In the data dir,write/copy the three following python snippet as 
- 1. pandas.py
- 2. polars.py
- 3. pyarrow.py

```python
#### pandas.py
import pandas as pd

# Load both Parquet files
df1 = pd.read_parquet("train-00000-of-00002.parquet")
df2 = pd.read_parquet("train-00001-of-00002.parquet")

# Concatenate the DataFrames
df = pd.concat([df1, df2], ignore_index=True)

# Write to CSV with a specific name
df.to_csv("pandasolar.csv", index=False)
```

```python
#### polars.py
import polars as pl

# Load both Parquet files
df1 = pl.read_parquet("train-00000-of-00002.parquet")
df2 = pl.read_parquet("train-00001-of-00002.parquet")

# Concatenate the DataFrames
df = pl.concat([df1, df2])

# Write to CSV with a specific name
df.write_csv("polarssolar.csv")
```

```python
# pyarrow.py
import pyarrow.parquet as pq
import pyarrow.csv as pc
import pyarrow as pa

# Load both Parquet files
table1 = pq.read_table("train-00000-of-00002.parquet")
table2 = pq.read_table("train-00001-of-00002.parquet")

# Concatenate the tables
table = pa.concat_tables([table1, table2])

# Write to CSV with a specific name
pc.write_csv(table, "pyarrowsolar.csv")
``````

```

## Level 4 Finish Line

- You've just downloaded your first AI model and dataset. Congrats, you're officially ahead of 99.9% of your peers. And most professionals.

