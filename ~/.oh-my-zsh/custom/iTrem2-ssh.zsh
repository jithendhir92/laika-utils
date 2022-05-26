# tabc <profile name> do the profile change
function tabc() {
  NAME=$1; if [ -z "$NAME" ]; then NAME="Default"; fi
  # if you have trouble with this, change
  # "Default" to the name of your default theme
  echo -e "\033]50;SetProfile=$NAME\a"
}

# reset the terminal profile to Default  when exit from the ssh session
function tab-reset() {
    NAME="Default"
    echo -e "\033]50;SetProfile=$NAME\a"
}

# selecting different terminal profile according to ssh'ing host
# tabc <profile name> do the profile change
#   1. Production profile to production server (ssh eranga@production_box)
#   2. Staging profile to staging server(ssh eranga@staging_box)
#   3. Other profile to any other server(test server, amazon box etc)
function colorssh() {
    input=$*
    echo "####### SSH to ${input} #######"
    ipAddrArray=(${(@s:.:)input})
    networkId=${ipAddrArray[2]}
    gcpNetworkIds=("116")
    #echo ${ipAddrArray}
    #echo ${networkId}
    #echo ${gcpNetworkIds}

    if [[ -n "$ITERM_SESSION_ID" ]]; then
        trap "tab-reset" INT EXIT
        if (($gcpNetworkIds[(Ie)$networkId])); then
          echo "####### Site - GCP #######"
          tabc GCP
        else
          echo "####### Site - FCP #######"
          tabc FCP
        fi
    fi
    ssh $*
}
compdef _ssh tabc=ssh

function colorgcloud() {
    if [[ -n "$ITERM_SESSION_ID" ]]; then
        trap "tab-reset" INT EXIT
        tabc GCP
    fi
    gcloud $*
}
compdef _gcloud tabc=gcloud

# creates an alias to ssh
# when execute ssh from the terminal it calls to colorssh function
alias ssh="colorssh"
alias gcloud="colorgcloud"
