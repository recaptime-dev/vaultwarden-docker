FROM gitpod/workspace-full

# Install Railway CLI and Divio CLI first
RUN sudo sh -c "$(curl -sSL https://raw.githubusercontent.com/railwayapp/cli/master/install.sh)" \
    && pip3 install -U divio-cli

# Then install the GitHub CLI
RUN sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0 \
    && sudo apt-add-repository https://cli.github.com/packages \
    && sudo apt update && sudo apt install gh \
    && sudo rm -rf /var/lib/apt/lists/*