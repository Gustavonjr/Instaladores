# Importa a biblioteca necessária para criar a interface gráfica
Add-Type -AssemblyName System.Windows.Forms

# Carrega a classe Log
. "$PSScriptRoot\Log.ps1"

# Cria uma instância da classe Log
$log = [Log]::new()

# Carrega a classe ProgramInstaller
. "$PSScriptRoot\ProgramInstaller.ps1"

# Cria uma instância da classe ProgramInstaller
$programInstaller = [ProgramInstaller]::new()

# Cria uma janela
$Form = New-Object System.Windows.Forms.Form
$Form.Text = "Programa PowerShell"
$Form.Size = New-Object System.Drawing.Size(300,200)

# Cria um botão para copiar arquivos
$ButtonCopy = New-Object System.Windows.Forms.Button
$ButtonCopy.Location = New-Object System.Drawing.Point(50,50)
$ButtonCopy.Size = New-Object System.Drawing.Size(200,30)
$ButtonCopy.Text = "Copiar Arquivos"

# Cria um botão para instalar arquivos
$ButtonInstall = New-Object System.Windows.Forms.Button
$ButtonInstall.Location = New-Object System.Drawing.Point(50,100)
$ButtonInstall.Size = New-Object System.Drawing.Size(200,30)
$ButtonInstall.Text = "Instalar Arquivos"

# Adiciona os botões à janela
$Form.Controls.Add($ButtonCopy)
$Form.Controls.Add($ButtonInstall)

 # Define o caminho de origem e destino do arquivo
 $origem = "\\e0211\Arquivos\Formatação\"
 $destino = "C:\temp\formatacao\arquivos\"

# Cria uma ação para o botão Copiar Arquivos
$ButtonCopy.Add_Click({
    # Coloque aqui o código para copiar os arquivos

    # Verifica se a pasta de destino existe, caso contrário, cria-a
    Write-Host "Verificando diretorios..."

    if (-not (Test-Path -Path "C:\temp\formatacao")) {
        New-Item -ItemType Directory -Path "C:\temp\formatacao" | Out-Null
        Write-Host "Pasta C:\temp\formatacao criada"
    }

    Write-Host "Copiando arquivos..."

     # Copia o arquivo
    Copy-Item -Path $origem -Destination $destino -Recurse -Force

    # Exibe uma mensagem de sucesso
    Write-Host "Arquivo copiado com sucesso."

    $log.WriteLog("Arquivos copiados de $origem para $destino")

})

# Cria uma ação para o botão Instalar Arquivos
$ButtonInstall.Add_Click({
    # Cria uma nova janela para os botões
    $InstallWindow = New-Object System.Windows.Forms.Form
    $InstallWindow.Text = "Instalar Arquivos"
    $InstallWindow.AutoSize = $true

    # Cria o botão 1
    $Button1 = New-Object System.Windows.Forms.Button
    $Button1.Location = New-Object System.Drawing.Point(10, 10)
    $Button1.Size = New-Object System.Drawing.Size(100, 30)
    $Button1.Text = "Browser"

    # Adiciona ação para o botão browser
    $Button1.Add_Click({
        # Coloque aqui o código para a ação do botão 1
        Write-Host "Browser"

    # Define o caminho do instalador do programa
    $installerPath = "C:\TEMP\formatacao\arquivos\ChromeStandaloneSetup64.exe"

    # Exemplo de instalação do Programa 1
    $programInstaller.InstallProgramNoMSI($installerPath)

    # Exemplo de gravação de log
    $log.WriteLog("$installerPath instalado com sucesso.")

    })

    # Cria o Compactador
    $Button2 = New-Object System.Windows.Forms.Button
    $Button2.Location = New-Object System.Drawing.Point(10, 40)
    $Button2.Size = New-Object System.Drawing.Size(100, 30)
    $Button2.Text = "Compactador"

    # Adiciona ação para o botão 2
    $Button2.Add_Click({
        # Coloque aqui o código para a ação do botão 2
        Write-Host "Compactador"



    })

    # Cria o botão 3
    $Button3 = New-Object System.Windows.Forms.Button
    $Button3.Location = New-Object System.Drawing.Point(10, 70)
    $Button3.Size = New-Object System.Drawing.Size(100, 30)
    $Button3.Text = "Arquivo 3"

    # Adiciona ação para o botão 3
    $Button3.Add_Click({
        # Coloque aqui o código para a ação do botão 3
        Write-Host "Compactador"
    })

    # Cria o botão 4
    $Button3 = New-Object System.Windows.Forms.Button
    $Button3.Location = New-Object System.Drawing.Point(10, 70)
    $Button3.Size = New-Object System.Drawing.Size(100, 30)
    $Button3.Text = "Arquivo 3"

    # Adiciona ação para o botão 3
    $Button3.Add_Click({
        # Coloque aqui o código para a ação do botão 3
        Write-Host "Compactador"
    })

    # Adiciona os botões à janela
    $InstallWindow.Controls.Add($Button1)
    $InstallWindow.Controls.Add($Button2)
    $InstallWindow.Controls.Add($Button3)

    # Mostra a janela
    $InstallWindow.ShowDialog()
})




# Mostra a janela
$Form.ShowDialog()
