class Menu {
    [System.Windows.Forms.MenuStrip] $MenuStrip
    [System.Windows.Forms.ToolStripMenuItem] $MenuItem1
    [System.Windows.Forms.ToolStripMenuItem] $MenuItem2
    [System.Windows.Forms.ToolStripMenuItem] $MenuItem3
    [System.Windows.Forms.ToolStripMenuItem] $MenuItem4

    Menu() {
        # Cria o menu strip
        $this.MenuStrip = New-Object System.Windows.Forms.MenuStrip
        #
        $this.MenuItem1 = New-Object System.Windows.Forms.ToolStripMenuItem
        $this.MenuItem1.Text = "Config"
        $this.MenuItem1.Add_Click({

                . "$PSScriptRoot\config.ps1"
            })
        #
        $this.MenuItem4 = New-Object System.Windows.Forms.ToolStripMenuItem
        $this.MenuItem4.Text = "Manual"
        $this.MenuItem4.Add_Click({

            Start-Process "http://10.0.2.248/Formatacao-SPB.html"

            })

        $this.MenuItem2 = New-Object System.Windows.Forms.ToolStripMenuItem
        $this.MenuItem2.Text = "Exit"
        $this.MenuItem2.Add_Click({

                $form.Close()
            })

        $this.MenuItem3 = New-Object System.Windows.Forms.ToolStripMenuItem
        $this.MenuItem3.Text = "Help"
        $this.MenuItem3.Add_Click({

                Add-Type -AssemblyName PresentationFramework

                # Função para exibir a janela com as informações
                function MostrarJanela {
                    # Criar a janela
                    $janela = New-Object -TypeName System.Windows.Window
                    $janela.Title = "Informações"
                    $janela.Width = 400
                    $janela.Height = 200
                    $janela.WindowStartupLocation = "CenterScreen"
                    $janela.ResizeMode = "NoResize"

                    # Criar o rótulo para exibir as informações
                    $rotulo = New-Object -TypeName System.Windows.Controls.Label
                    $rotulo.Content = "Usuário: administrador"

                    # Adicionar o rótulo à janela
                    $janela.Content = $rotulo

                    # Exibir a janela
                    $janela.ShowDialog() | Out-Null
                }

                MostrarJanela

            })

        # Adiciona os itens ao menu strip
        $this.MenuStrip.Items.AddRange(@($this.MenuItem1, $this.MenuItem3, $this.MenuItem4, $this.MenuItem2))
    }

    [void] Show([System.Windows.Forms.Form] $form) {
        # Adiciona o menu strip à janela principal
        $form.Controls.Add($this.MenuStrip)
    }
}
