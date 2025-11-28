# shellcheck shell=bash
# ~/.bash_profile

export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"

# Modular/Mojo configuration
export MODULAR_HOME="${HOME}/.modular"
export PATH="${MODULAR_HOME}/pkg/packages.modular.com_mojo/bin:${PATH}"

# Git configuration
export GIT_DISCOVERY_ACROSS_FILESYSTEM=1

# Neovim configuration
export PATH="${HOME}/.local/bin:${HOME}/.cargo/bin:${HOME}/bin:${PATH}"

export PATH="${PATH}:${HOME}/.local/share/nvim/mason/bin"
export EDITOR="nvim"
export VISUAL="nvim"
export SUDO_EDITOR="nvim"

# Network configuration
export ENABLE_NETWORK_TESTS=1

# terminal type
export TERM=xterm-256color

export PATH="${HOME}/bin:${PATH}"
#Pipewire
export SPA_LIB_DIR="/usr/lib/spa-0.2"
# AEC (Acoustic Echo Cancellation)
# Path: $SPA_LIB_DIR/aec/libspa-aec-webrtc.so
# Purpose: Removes echo during audio communication. WebRTC-based AEC is useful for improving audio quality in calls.

# ALSA (Advanced Linux Sound Architecture)
# Path: $SPA_LIB_DIR/alsa/libspa-alsa.so
# Purpose: Interface for ALSA, allowing PipeWire to interact with ALSA sound devices for playback and capture.

# Audio Convert
# Path: $SPA_LIB_DIR/audioconvert/libspa-audioconvert.so
# Purpose: Handles conversion between different audio formats (sample rate, bit depth, channel configuration).

# Audio Mixer
# Path: $SPA_LIB_DIR/audiomixer/libspa-audiomixer.so
# Purpose: Mixes multiple audio inputs into one output, useful for combining streams.

# Audio Test Source
# Path: $SPA_LIB_DIR/audiotestsrc/libspa-audiotestsrc.so
# Purpose: Generates test tones or noise for testing purposes.

# AVB (Audio Video Bridging)
# Path: $SPA_LIB_DIR/avb/libspa-avb.so
# Purpose: Provides support for Audio Video Bridging, often used in professional A/V setups.

# BlueZ 5 (Bluetooth)
# Path: $SPA_LIB_DIR/bluez5/libspa-bluez5.so
# Purpose: Manages Bluetooth audio devices, including headsets and speakers.

# BlueZ 5 Codecs
# Directory Path: $SPA_LIB_DIR/bluez5/
# Purpose: Provides different Bluetooth audio codecs, including AAC, aptX, SBC, LDAC, etc.

# Control
# Path: $SPA_LIB_DIR/control/libspa-control.so
# Purpose: Provides control elements that are used for managing various audio and video properties.

# Libcamera
# Path: $SPA_LIB_DIR/libcamera/libspa-libcamera.so
# Purpose: Interface for libcamera, enabling use of cameras managed by libcamera.

# Support Libraries
# Path: $SPA_LIB_DIR/support/libspa-support.so
# Purpose: Provides supporting functions used by various SPA modules, such as helpers for device management.

# V4L2 (Video for Linux 2)
# Path: $SPA_LIB_DIR/v4l2/libspa-v4l2.so
# Purpose: Manages video devices through the V4L2 interface, commonly used for webcams and other video capture devices.

# Video Convert
# Path: $SPA_LIB_DIR/videoconvert/libspa-videoconvert.so
# Purpose: Converts between different video formats (resolution, colorspace).

# Video Test Source
# Path: $SPA_LIB_DIR/videotestsrc/libspa-videotestsrc.so
# Purpose: Generates video test patterns for diagnostics.
# PipeWire Environment Variables
export PIPEWIRE_RUNTIME_DIR="/run/user/1000/pipewire-0"
# ALSA configuration directory
export ALSA_CONFIG_PATH="/etc/alsa/conf.d"

# ALSA plugin directory path
export ALSA_PLUGIN_DIR="/usr/lib/alsa-lib"

# Enable A2DP profile for Bluetooth audio (PipeWire BlueZ5)
export BLUEZ5_ENABLE_A2DP=true

# Enable hardware volume control for Bluetooth (PipeWire BlueZ5)
export BLUEZ5_HW_VOLUME=true

# Enable HFP profile for Bluetooth hands-free (PipeWire BlueZ5)
export BLUEZ5_ENABLE_HFP=true

# Enable SBC XQ codec for higher quality Bluetooth audio (PipeWire BlueZ5)
export BLUEZ5_ENABLE_SBC_XQ=true

# Path for GStreamer plugins
export GST_PLUGIN_PATH="/usr/lib/gstreamer-1.0"

# Path to LADSPA plugin directory
export LADSPA_PATH="/usr/lib/ladspa"

# JACK plugin path for PipeWire JACK emulation
export JACK_PLUGIN_PATH="/usr/lib/jack"

# PipeWire JACK library for JACK emulation
export PIPEWIRE_JACK_LIB="/usr/lib/jack"

# Path to the PipeWire binary directory
export PIPEWIRE_BIN_DIR="/usr/bin"

# Path to the PipeWire main configuration file
export PIPEWIRE_CONFIG_FILE="/etc/pipewire/pipewire.conf"

# PipeWire latency configuration for audio processing
export PIPEWIRE_LATENCY="128/48000"

# Directory for PipeWire modules
#export PIPEWIRE_MODULE_DIR="/usr/lib/pipewire-0.3:/usr/lib64/pipewire-0.3"

# PulseAudio runtime directory (managed by PipeWire)
export PULSE_RUNTIME_PATH="/run/user/1000/pulse"

# Directory for WirePlumber configuration files
export WIREPLUMBER_CONFIG_DIR="/etc/wireplumber"

# Pacman path
export PACMAN="/usr/bin/pacman"

#XDG
export XDG_RUNTIME_DIR=/run/user/1000

# Initialize zoxide for faster directory navigation
eval "$(zoxide init bash)" || true


