# Importa a biblioteca necessária para criar a interface gráfica
Add-Type -AssemblyName System.Windows.Forms
. "$PSScriptRoot\Menu.ps1"
. "$PSScriptRoot\ProgramInstaller.ps1"
. "$PSScriptRoot\Log.ps1"

# Cria uma instâncias
$log = [Log]::new()
$programInstaller = [ProgramInstaller]::new()
$menu = [Menu]::new()


# Pegar o caminho do arquivo de configuração
$caminhoArquivo = Join-Path -Path $PSScriptRoot -ChildPath "config.txt"

# Le o conteudo do arquivo
$conteudo = Get-Content $caminhoArquivo

# Inicializa as variáveis
$origem = ""
$destino = ""

# Percorre cada linha do conteúdo do arquivo
foreach ($linha in $conteudo) {
    # Verifica se a linha contém a palavra "Origem:"
    if ($linha -like "Origem:*") {
        # Remove a parte "Origem: " da linha e atribui o valor à variável $origem
        $origem = $linha -replace "Origem: ", ""
    }

    # Verifica se a linha contém a palavra "Destino:"
    if ($linha -like "Destino:*") {
        # Remove a parte "Destino: " da linha e atribui o valor à variável $destino
        $destino = $linha -replace "Destino: ", ""
    }
}

# Cria uma janela (main)
$Form = New-Object System.Windows.Forms.Form
$Form.Text = "Informatica SPB"
$Form.Size = New-Object System.Drawing.Size(300, 230)
$form.FormBorderStyle = "Sizable"

# Chama o método Show() passando a janela principal como parâmetro
$menu.Show($form)

# Cria um botão para copiar arquivos
$ButtonCopy = New-Object System.Windows.Forms.Button
$ButtonCopy.Location = New-Object System.Drawing.Point(50, 50)
$ButtonCopy.Size = New-Object System.Drawing.Size(200, 30)
$ButtonCopy.Text = "Copiar Arquivos"

# Cria um botão para instalar arquivos
$ButtonInstall = New-Object System.Windows.Forms.Button
$ButtonInstall.Location = New-Object System.Drawing.Point(50, 100)
$ButtonInstall.Size = New-Object System.Drawing.Size(200, 30)
$ButtonInstall.Text = "Instalar Arquivos"

# Adiciona os botões à janela
$Form.Controls.Add($ButtonCopy)
$Form.Controls.Add($ButtonInstall)

# Cria uma barra de progresso (loading)
$ProgressBar = New-Object System.Windows.Forms.ProgressBar
$ProgressBar.Location = New-Object System.Drawing.Point(50, 100)
$ProgressBar.Size = New-Object System.Drawing.Size(200, 30)
$ProgressBar.Style = 'Continuous'
$ProgressBar.Visible = $false

# Cria uma ação para o botão Copiar Arquivos
$ButtonCopy.Add_Click({

        # Verificando se existe o local/diretorio, se não tiver vai ser criado.
        if (-not (Test-Path -Path "C:\temp\formatacao")) {
            New-Item -ItemType Directory -Path "C:\temp\formatacao" | Out-Null
            Write-Host "Pasta C:\temp\formatacao criada"
            $log.WriteLog("Pasta C:\temp\formatacao criada")
        }

        # Obtém a lista de arquivos na origem
        $files = Get-ChildItem -Path $origem -Recurse

        # Inicializa a barra de progresso
        $progressBar = New-Object System.Windows.Forms.ProgressBar
        $progressBar.Location = New-Object System.Drawing.Point(50, 150)
        $progressBar.Size = New-Object System.Drawing.Size(200, 20)
        $progressBar.Minimum = 0
        $progressBar.Maximum = $files.Count
        $progressBar.Value = 0

        # Adiciona a barra de progresso à janela
        $Form.Controls.Add($progressBar)

        # Copia os arquivos
        foreach ($file in $files) {
            $destinationFilePath = $file.FullName.Replace($origem, $destino)

            # Verifica se o arquivo já existe na pasta de destino
            if (-not (Test-Path -Path $destinationFilePath)) {
                # Copia o arquivo
                Copy-Item -Path $file.FullName -Destination $destinationFilePath -Force
            }

            # Atualiza o valor da barra de progresso
            $progressBar.Value++
        }

        # Exibe uma mensagem de sucesso
        [System.Windows.Forms.MessageBox]::Show("Arquivos copiados com sucesso.")

        # Remove a barra de progresso da janela
        $Form.Controls.Remove($progressBar)
        $progressBar.Dispose()

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

                # Define o caminho do instalador do programa
                $installerPath = "C:\TEMP\formatacao\arquivos\Browser\ChromeStandaloneSetup64.exe"
            
                # Exemplo de instalação do Programa 1
                $programInstaller.InstallProgramNoMSI($installerPath)

                #log
                $log.WriteLog("Instalação do $installerPath cancelada e/ou finalizada com sucesso.")
            })

        # Cria o Botão Compactador
        $Button2 = New-Object System.Windows.Forms.Button
        $Button2.Location = New-Object System.Drawing.Point(10, 50)
        $Button2.Size = New-Object System.Drawing.Size(100, 30)
        $Button2.Text = "Compactador"

        # Adiciona ação para o Botão Compactador
        $Button2.Add_Click({
                # Define o caminho do instalador do programa
                $installerPath = "C:\TEMP\formatacao\arquivos\Compactador\7z2201-x64.exe"

                # Exemplo de instalação do Programa 1
                $programInstaller.InstallProgramNoMSI($installerPath)

                # Exemplo de gravação de log
                $log.WriteLog("Instalação do $installerPath cancelada e/ou finalizada com sucesso.")


            })

        # Cria o botão LibreOffice
        $Button3 = New-Object System.Windows.Forms.Button
        $Button3.Location = New-Object System.Drawing.Point(10, 90)
        $Button3.Size = New-Object System.Drawing.Size(100, 30)
        $Button3.Text = "LibreOffice"

        # Adiciona ação para o botão libreOffice
        $Button3.Add_Click({

                # Define o caminho do instalador do programa
                $installerPath = "C:\TEMP\formatacao\arquivos\LibreOffice\LibreOffice_7.5.3_Win_x86-64.msi"

                # Exemplo de instalação do Programa 1
                $programInstaller.InstallProgramNoMSI($installerPath)

                # Exemplo de gravação de log
                $log.WriteLog("Instalação do $installerPath cancelada e/ou finalizada com sucesso.")

            })

        # Cria o botão BDE
        $Button4 = New-Object System.Windows.Forms.Button
        $Button4.Location = New-Object System.Drawing.Point(10, 130)
        $Button4.Size = New-Object System.Drawing.Size(100, 30)
        $Button4.Text = "BDE"

        # Adiciona ação para o botão bde
        $Button4.Add_Click({

                # Define o caminho do instalador do programa
                $installerPath = "C:\TEMP\formatacao\arquivos\BDE\bde_vector_64.exe"

                $programInstaller.InstallProgramNoMSI($installerPath)

                $log.WriteLog("Instalação do $installerPath cancelada e/ou finalizada com sucesso.")

                if ((Test-Path -Path "C:\Program Files (x86)\Common Files\Borland Shared\BDE")) {

                    # Define o caminho de origem e destino dos arquivos de config
                    $origemBDE_idapi32 = "C:\TEMP\formatacao\arquivos\BDE\idapi32.cfg"
                    $origemBDE_sqlora8 = "C:\TEMP\formatacao\arquivos\BDE\sqlora8.dll"
                    $destinoBDE = "C:\Program Files (x86)\Common Files\Borland Shared\BDE\"

                    Copy-Item -Path $origemBDE_idapi32 -Destination $destinoBDE -Force
                    $log.WriteLog("$origemBDE_idapi32 copiado para $destinoBDE")
                    Copy-Item -Path $origemBDE_sqlora8 -Destination $destinoBDE -Force
                    $log.WriteLog("$origemBDE_sqlora8 copiado para $destinoBDE")
                    [System.Windows.Forms.MessageBox]::Show("Realize a conferencia das configurações")
                    $log.WriteLogVazio("Solicitado conferencia das configurações do BDE")
                    Invoke-Item -Path "C:\Program Files (x86)\Common Files\Borland Shared\BDE\bdeadmin.exe"
                }

            })


        # Cria o botão Oracle11g
        $Button5 = New-Object System.Windows.Forms.Button
        $Button5.Location = New-Object System.Drawing.Point(10, 170)
        $Button5.Size = New-Object System.Drawing.Size(100, 30)
        $Button5.Text = "Oracle 11g"

        # Adiciona ação para o botão Oracle11g
        $Button5.Add_Click({

                # Define o caminho do instalador do programa
                $installerPath = "C:\TEMP\formatacao\arquivos\Oracle 11g\client\setup.exe"

                $programInstaller.InstallProgramNoMSI($installerPath)

                $log.WriteLog("Instalação do $installerPath cancelada e/ou finalizada com sucesso.")

                if ((Test-Path -Path "C:\app\Administrador\product\11.2.0\client_1\network\admin")) {

                    # Define o caminho de origem e destino dos arquivos de config
                    $origemTNS = "C:\TEMP\formatacao\arquivos\Oracle 11g\Tnsnames.ora"
                    $destinoTNS = "C:\app\Administrador\product\11.2.0\client_1\network\admin"

                    Copy-Item -Path $origemTNS -Destination $destinoTNS -Force
                    $log.WriteLog("$origemTNS copiado para $destinoTNS")
                }

                else {
                    $log.WriteLog("C:\app\Administrador\product\11.2.0\client_1\network\admin Não encontrado, realize a configuração oracle manualmente.")
                    [System.Windows.Forms.MessageBox]::Show("C:\app\Administrador\product\11.2.0\client_1\network\admin Não encontrado, realize a configuração oracle(TNS) manualmente.")
                }


            })

        # Cria o botão LibreOffice
        $Button6 = New-Object System.Windows.Forms.Button
        $Button6.Location = New-Object System.Drawing.Point(10, 210)
        $Button6.Size = New-Object System.Drawing.Size(100, 30)
        $Button6.Text = "Acesso Remoto"

        # Adiciona ação para o botão libreOffice
        $Button6.Add_Click({

                # Define o caminho do instalador do programa
                $installerPath = "C:\TEMP\formatacao\arquivos\Acesso remoto\UltraVNC_1_3_81_X64_Setup.exe"

                # Exemplo de instalação do Programa 1
                $programInstaller.InstallProgramNoMSI($installerPath)

                # Exemplo de gravação de log
                $log.WriteLog("Instalação do $installerPath cancelada e/ou finalizada com sucesso.")

            })


        # Cria o botão Excluir arquvios
        $ButtonE = New-Object System.Windows.Forms.Button
        $ButtonE.Location = New-Object System.Drawing.Point(140, 10)
        $ButtonE.Size = New-Object System.Drawing.Size(100, 30)
        $ButtonE.BackColor = [System.Drawing.Color]::FromArgb(120, 0, 0)
        $ButtonE.ForeColor = [System.Drawing.Color]::White

        $ButtonE.Text = "Excluir Arq."
        $ButtonE.Add_Click({
                Remove-Item $destino -Recurse -Force
                $log.WriteLog("Realizado a exclusão recursiva dos arquivo do diretorio $destino")
            })

        # Cria o botão Excluir arquvios
        $ButtonD = New-Object System.Windows.Forms.Button
        $ButtonD.Location = New-Object System.Drawing.Point(140, 50)
        $ButtonD.Size = New-Object System.Drawing.Size(100, 30)
        $ButtonD.BackColor = [System.Drawing.Color]::FromArgb(120, 0, 50)
        $ButtonD.ForeColor = [System.Drawing.Color]::White

        $ButtonD.Text = "Windows Defender"
        $ButtonD.Add_Click({
                # Define o caminho do instalador do programa
                $installerPath = "C:\TEMP\formatacao\arquivos\DefenderControl\dControl\dControl.exe"

                # Exemplo de instalação do Programa 1
                $programInstaller.InstallProgramNoMSI($installerPath)
 
                # Exemplo de gravação de log
                $log.WriteLog("Dcontrol")
            })

        # Cria o botão drivers
        $ButtonS = New-Object System.Windows.Forms.Button
        $ButtonS.Location = New-Object System.Drawing.Point(140, 90)
        $ButtonS.Size = New-Object System.Drawing.Size(100, 30)
        $ButtonS.BackColor = [System.Drawing.Color]::FromArgb(0, 120, 50)
        $ButtonS.ForeColor = [System.Drawing.Color]::White

        $ButtonS.Text = "Drivers"
        $ButtonS.Add_Click({
                # Define o caminho do instalador do programa
                $installerPath = "\\10.0.20.20\files\SOFTWARE\NEW\DRIVERs\SDI_RUS\SDI_x64_R2201.exe"

                # Exemplo de instalação do Programa 1
                $programInstaller.InstallProgramNoMSI($installerPath)
 
                # Exemplo de gravação de log
                $log.WriteLog("Drivers")
            })

        # Cria o botão Visual
        $Buttonv = New-Object System.Windows.Forms.Button
        $Buttonv.Location = New-Object System.Drawing.Point(140, 130)
        $Buttonv.Size = New-Object System.Drawing.Size(100, 30)
        $Buttonv.BackColor = [System.Drawing.Color]::FromArgb(120, 120, 0)
        $Buttonv.ForeColor = [System.Drawing.Color]::White

        $Buttonv.Text = "Visual C"
        $Buttonv.Add_Click({
                # Define o caminho do instalador do programa
                $installerPath = "C:\TEMP\formatacao\arquivos\VisualC\VisualCppRedist_AIO_x86_x64.exe"

                # Exemplo de instalação do Programa 1
                $programInstaller.InstallProgramNoMSI($installerPath)
 
                # Exemplo de gravação de log
                $log.WriteLog("Visual C")
            })

        # Adiciona os botões à janela
        $InstallWindow.Controls.Add($Button1)
        $InstallWindow.Controls.Add($Button2)
        $InstallWindow.Controls.Add($Button3)
        $InstallWindow.Controls.Add($Button4)
        $InstallWindow.Controls.Add($Button5)
        $InstallWindow.Controls.Add($Button6)
        $InstallWindow.Controls.Add($ButtonE)
        $InstallWindow.Controls.Add($ButtonD)
        $InstallWindow.Controls.Add($ButtonS)
        $InstallWindow.Controls.Add($Buttonv)

        $InstallWindow.ShowDialog()
    })

$Form.ShowDialog()
