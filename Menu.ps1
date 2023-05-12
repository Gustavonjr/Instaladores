class Menu {
    [System.Windows.Forms.MenuStrip] $MenuStrip
    [System.Windows.Forms.ToolStripMenuItem] $MenuItem1
    [System.Windows.Forms.ToolStripMenuItem] $MenuItem2
    [System.Windows.Forms.ToolStripMenuItem] $MenuItem3

    Menu() {
        # Cria o menu strip
        $this.MenuStrip = New-Object System.Windows.Forms.MenuStrip

        # Cria o primeiro item do menu
        $this.MenuItem1 = New-Object System.Windows.Forms.ToolStripMenuItem
        $this.MenuItem1.Text = "Configurações"
        $this.MenuItem1.Add_Click({
            # Coloque aqui o código para a ação do primeiro item do menu
            Write-Host "Configurações selecionada"
        })

        # Cria o segundo item do menu
        $this.MenuItem2 = New-Object System.Windows.Forms.ToolStripMenuItem
        $this.MenuItem2.Text = "Exit"
        $this.MenuItem2.Add_Click({
            # Coloque aqui o código para a ação do segundo item do menu
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
