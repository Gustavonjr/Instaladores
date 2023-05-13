Add-Type -AssemblyName System.Windows.Forms
class ProgramInstaller {
    [void] InstallProgramNoMSI($installerPath) {
        # Verifica se o instalador existe
        if (Test-Path $installerPath) {
            # Executa o instalador do programa
            Start-Process -FilePath $installerPath -Wait

            # Exibe uma mensagem de confirmação
            [System.Windows.Forms.MessageBox]::Show("Processo finalizado")
        }
        else {
            # Exibe uma mensagem de erro se o instalador não for encontrado
            [System.Windows.Forms.MessageBox]::Show("O instalador $installerPath não foi encontrado")
        }
    }
}