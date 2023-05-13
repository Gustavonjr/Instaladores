class Menu {
    [System.Windows.Forms.MenuStrip] $MenuStrip
    [System.Windows.Forms.ToolStripMenuItem] $MenuItem1
    [System.Windows.Forms.ToolStripMenuItem] $MenuItem2
    [System.Windows.Forms.ToolStripMenuItem] $MenuItem3

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
        $this.MenuItem2 = New-Object System.Windows.Forms.ToolStripMenuItem
        $this.MenuItem2.Text = "Exit"
        $this.MenuItem2.Add_Click({

                $form.Close()
            })

        # Adiciona os itens ao menu strip
        $this.MenuStrip.Items.AddRange(@($this.MenuItem1, $this.MenuItem2))
    }

    [void] Show([System.Windows.Forms.Form] $form) {
        # Adiciona o menu strip à janela principal
        $form.Controls.Add($this.MenuStrip)
    }
}
