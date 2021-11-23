# detect what we have
if [  $(uname -a | grep -c "Microsoft") -eq 1 ]; then
    export ISWSL=1 # WSL 1
elif [ $(uname -a | grep -c "microsoft") -eq 1 ]; then
    export ISWSL=2 # WSL 2
else
    export ISWSL=0
fi

if [ ${ISWSL} -eq 1 ]; then
    # WSL 1 could use AF_UNIX sockets from Windows side directly
    if [ -n ${WSL_AGENT_HOME} ]; then
        export GNUPGHOME=${WSL_AGENT_HOME}
        export SSH_AUTH_SOCK=${WSL_AGENT_HOME}/S.gpg-agent.ssh
    fi
elif [ ${ISWSL} -eq 2 ]; then
    # WSL 2 require socat to create socket on Linux side and sorelay on the Windows side to interop
    if [ ! -d ${HOME}/.gnupg ]; then
        mkdir ${HOME}/.gnupg
        chmod 0700 ${HOME}/.gnupg
    fi
    if [ -n ${WIN_GNUPG_HOME} ]; then
        # setup gpg-agent socket
        _sock_name=${HOME}/.gnupg/S.gpg-agent
        ss -a | grep -q ${_sock_name}
        if [ $? -ne 0  ]; then
            rm -f ${_sock_name}
            ( setsid socat UNIX-LISTEN:${_sock_name},fork EXEC:"${HOME}/winhome/.wsl/sorelay.exe -a ${WIN_GNUPG_HOME//\:/\\:}/S.gpg-agent",nofork & ) >/dev/null 2>&1
        fi
        # setup gpg-agent.extra socket
        _sock_name=${HOME}/.gnupg/S.gpg-agent.extra
        ss -a | grep -q ${_sock_name}
        if [ $? -ne 0  ]; then
            rm -f ${_sock_name}
            ( setsid socat UNIX-LISTEN:${_sock_name},fork EXEC:"${HOME}/winhome/.wsl/sorelay.exe -a ${WIN_GNUPG_HOME//\:/\\:}/S.gpg-agent.extra",nofork & ) >/dev/null 2>&1
        fi
        unset _sock_name
    fi
    if [ -n ${WIN_AGENT_HOME} ]; then
        # and ssh-agent socket
        export SSH_AUTH_SOCK=${HOME}/.gnupg/S.gpg-agent.ssh
        ss -a | grep -q ${SSH_AUTH_SOCK}
        if [ $? -ne 0  ]; then
            rm -f ${SSH_AUTH_SOCK}
            ( setsid socat UNIX-LISTEN:${SSH_AUTH_SOCK},fork EXEC:"${HOME}/winhome/.wsl/sorelay.exe ${WIN_AGENT_HOME//\:/\\:}/S.gpg-agent.ssh",nofork & ) >/dev/null 2>&1
        fi
    fi
else
    # Do whatever -- this is real Linux
fi

