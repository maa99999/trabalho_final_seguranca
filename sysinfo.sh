service sysinfo
{
    disable         = no
    socket_type     = stream
    protocol        = tcp
    wait            = no
    user            = nobody
    server          = /usr/local/bin/sysinfo.sh
    port            = 9090

    # Limitar os IPs que podem acessar o serviço
    only_from       = 192.168.1.0/24

    # Registrar conexões bem-sucedidas
    log_on_success  += HOST PID DURATION

    # Registrar tentativas de conexão falhas
    log_on_failure  += HOST ATTEMPT

    # Limitar número de conexões simultâneas
    instances       = 5

    # Tempo máximo de inatividade por conexão
    per_source      = 2

    # Tempo máximo de execução do serviço
    cps             = 10 30

    # Proteger contra DoS (ataques de negação de serviço)
    rlimit_cpu      = 1
    rlimit_as       = 512000

    # Aumentar a segurança, impedindo conexões desnecessárias
    nice            = 10
}
