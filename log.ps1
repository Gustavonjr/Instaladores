# Classe Log
class Log {
    [string] $logPath = "C:\temp\formatacao\log.txt"
    #Verifica se o arquivo de log.txt esta criadoe se não estiver será criado
    [void] WriteLog([string] $message) {
        if (-not (Test-Path $this.logPath)) {
            $null = New-Item -Path $this.logPath -ItemType File
        }

        $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        $logMessage = "Acao realizada em ${timestamp}: $message"
        $logMessage | Out-File -FilePath $this.logPath -Append
    }

    [void] WriteLogVazio([string] $message) {
        if (-not (Test-Path $this.logPath)) {
            $null = New-Item -Path $this.logPath -ItemType File
        }

        $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        $logMessage = "${timestamp}: $message"
        $logMessage | Out-File -FilePath $this.logPath -Append
    }
}
