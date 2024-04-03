!/bin/bash 
## these were coped from sourced commands normally available on manitou
module ()
{
    _module_raw "$@" 2>&1
}

_module_raw ()
{
    unset _mlshdbg;
    if [ "${MODULES_SILENT_SHELL_DEBUG:-0}" = '1' ]; then
        case "$-" in
            *v*x*)
                set +vx;
                _mlshdbg='vx'
            ;;
            *v*)
                set +v;
                _mlshdbg='v'
            ;;
            *x*)
                set +x;
                _mlshdbg='x'
            ;;
            *)
                _mlshdbg=''
            ;;
        esac;
    fi;
    unset _mlre _mlIFS;
    if [ -n "${IFS+x}" ]; then
        _mlIFS=$IFS;
    fi;
    IFS=' ';
    for _mlv in ${MODULES_RUN_QUARANTINE:-};
    do
        if [ "${_mlv}" = "${_mlv##*[!A-Za-z0-9_]}" -a "${_mlv}" = "${_mlv#[0-9]}" ]; then
            if [ -n "`eval 'echo ${'$_mlv'+x}'`" ]; then
                _mlre="${_mlre:-}${_mlv}_modquar='`eval 'echo ${'$_mlv'}'`' ";
            fi;
            _mlrv="MODULES_RUNENV_${_mlv}";
            _mlre="${_mlre:-}${_mlv}='`eval 'echo ${'$_mlrv':-}'`' ";
        fi;
    done;
    if [ -n "${_mlre:-}" ]; then
        eval `eval ${_mlre} /usr/bin/tclsh /cm/local/apps/environment-modules/4.5.3/libexec/modulecmd.tcl bash '"$@"'`;
    else
        eval `/usr/bin/tclsh /cm/local/apps/environment-modules/4.5.3/libexec/modulecmd.tcl bash "$@"`;
    fi;
    _mlstatus=$?;
    if [ -n "${_mlIFS+x}" ]; then
        IFS=$_mlIFS;
    else
        unset IFS;
    fi;
    unset _mlre _mlv _mlrv _mlIFS;
    if [ -n "${_mlshdbg:-}" ]; then
        set -$_mlshdbg;
    fi;
    unset _mlshdbg;
    return $_mlstatus
}
