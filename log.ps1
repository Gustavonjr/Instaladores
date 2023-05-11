# Classe Log
class Log {
    [string] $logPath = "C:\temp\formatacao\log.txt"

    [void] WriteLog([string] $message) {
        if (-not (Test-Path $this.logPath)) {
            $null = New-Item -Path $this.logPath -ItemType File
        }

        $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        $logMessage = "Acao realizada em ${timestamp}: $message"
        $logMessage | Out-File -FilePath $this.logPath -Append
    }
}
