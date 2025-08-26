#!/usr/bin/env bash

# Set debug mode flag: change to "true" to enable debug messages
DEBUG_MODE="false"

# Function to print debug messages if DEBUG_MODE is enabled
print_debug() {
    if [[ "${DEBUG_MODE}" == "true" ]]; then
        printf "%s\n" "$1"
    fi
}

# Qompass Configs: List of all configuration files
qompass_configs=".bash_profile .pathrc .basharc .crc .cudarc .containerrc .dotnetrc .erlrc .fortranrc .gh-completion.bash .gorc .haskellrc .hfrc .javarc .jsrc .llvmrc .luarc .mojorc .nimblerc .ocamlrc .perlrc .pianorc .pkgrc .phprc .pythonrc .qpgrc .qsslrc .rrc .rubyrc .rustrc .scalarc .swiftrc .zigrc"

# Function to source all Qompass configuration files
source_qompass_configs() {
    local all_success=true

    # Iterate over each configuration file and source it
    for rc_file in ${qompass_configs}; do
        if [[ -f "${HOME}/${rc_file}" ]]; then
            if ! source "${HOME}/${rc_file}"; then
                # Print debug message on failure
                print_debug "[DEBUG] Error: Failed to source ${rc_file}"
                all_success=false
            else
                # Print debug message on successful sourcing
                print_debug "[DEBUG] Sourced ${rc_file} successfully"
            fi
        else
            # Print debug message if file not found
            print_debug "[DEBUG] Warning: ${rc_file} not found"
            all_success=false
        fi
    done

    # Summary message after sourcing all files
    if [[ "${all_success}" == "true" ]]; then
        printf "Rock and Roll\n"
    else
        if [[ "${DEBUG_MODE}" == "true" ]]; then
            printf "[DEBUG] Bummer: Not all configurations loaded successfully\n"
        else
            printf "Bummer\n"
        fi
    fi
}

# Call the function to source Qompass configuration files
source_qompass_configs

# Export relevant paths after sourcing config files to ensure they contain all necessary values
export PATH
export CPATH
export LD_LIBRARY_PATH
export PKG_CONFIG_PATH

# Source compiler setup if available
if [[ -f "${HOME}/.compiler_setup.sh" ]]; then
    if ! source "${HOME}/.compiler_setup.sh"; then
        print_debug "[DEBUG] Warning: Failed to source .compiler_setup.sh"
    else
        print_debug "[DEBUG] Sourced .compiler_setup.sh successfully"
    fi
else
    print_debug "[DEBUG] Warning: .compiler_setup.sh not found"
fi

# Debug information for final environment variables
if [[ "${DEBUG_MODE}" == "true" ]]; then
    printf "[DEBUG] Final PATH: %s\n" "${PATH}"
    printf "[DEBUG] Final CPATH: %s\n" "${CPATH}"
    printf "[DEBUG] Final LD_LIBRARY_PATH: %s\n" "${LD_LIBRARY_PATH}"
    printf "[DEBUG] Final PKG_CONFIG_PATH: %s\n" "${PKG_CONFIG_PATH}"
fi

source ~/.compiler_setup.sh
