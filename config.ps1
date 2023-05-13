Add-Type -AssemblyName System.Windows.Forms

. "$PSScriptRoot\Log.ps1"
$log = [Log]::new()

class Configuracoes {
    [string]$origem
    [string]$destino

    Configuracoes([string]$origem, [string]$destino) {
        $this.origem = $origem
        $this.destino = $destino
    }
    
    [void] GravarConfiguracoes() {
        $configuracoes = "Origem: $($this.origem)`nDestino: $($this.destino)"
        
        if (-not (Test-Path $global:txtFilePath)) {
            New-Item -ItemType File -Path $global:txtFilePath -Force | Out-Null
        }
        
        $configuracoes | Out-File -FilePath $global:txtFilePath
        Write-Host "Configurações gravadas com sucesso."
    }
    
    [void] SetOrigem([string]$novaOrigem) {
        $this.origem = $novaOrigem
    }
    
    [void] SetDestino([string]$novoDestino) {
        $this.destino = $novoDestino
    }
    
    [string] GetOrigem() {
        return $this.origem
    }
    
    [string] GetDestino() {
        return $this.destino
    }
    
    
    [void] EditarConfiguracoes() {
    $form = New-Object System.Windows.Forms.Form
    $form.Text = "Editar Config"
    $form.Size = New-Object System.Drawing.Size(300, 150)
    $form.FormBorderStyle = "Sizable"
    $form.StartPosition = "CenterScreen"

    $labelOrigem = New-Object System.Windows.Forms.Label
    $labelOrigem.Location = New-Object System.Drawing.Point(10, 20)
    $labelOrigem.Size = New-Object System.Drawing.Size(80, 20)
    $labelOrigem.Text = "Origem:"
    $form.Controls.Add($labelOrigem)

    $textBoxOrigem = New-Object System.Windows.Forms.TextBox
    $textBoxOrigem.Location = New-Object System.Drawing.Point(90, 20)
    $textBoxOrigem.Size = New-Object System.Drawing.Size(180, 20)
    $textBoxOrigem.Text = $this.GetOrigem()  # Obtém o valor atualizado da origem
    $form.Controls.Add($textBoxOrigem)

    $labelDestino = New-Object System.Windows.Forms.Label
    $labelDestino.Location = New-Object System.Drawing.Point(10, 50)
    $labelDestino.Size = New-Object System.Drawing.Size(80, 20)
    $labelDestino.Text = "Destino:"
    $form.Controls.Add($labelDestino)

    $textBoxDestino = New-Object System.Windows.Forms.TextBox
    $textBoxDestino.Location = New-Object System.Drawing.Point(90, 50)
    $textBoxDestino.Size = New-Object System.Drawing.Size(180, 20)
    $textBoxDestino.Text = $this.GetDestino()  # Obtém o valor atualizado do destino
    $form.Controls.Add($textBoxDestino)

    $buttonSalvar = New-Object System.Windows.Forms.Button
    $buttonSalvar.Location = New-Object System.Drawing.Point(110, 90)
    $buttonSalvar.Size = New-Object System.Drawing.Size(80, 30)
    $buttonSalvar.Text = "Salvar"

    $configuracoes = $this

    $buttonSalvar.Add_Click({
        $origemAtualizada = $textBoxOrigem.Text
        $destinoAtualizado = $textBoxDestino.Text

        $configuracoes.SetOrigem($origemAtualizada)
        $configuracoes.SetDestino($destinoAtualizado)
        $configuracoes.GravarConfiguracoes()

        $form.Close()
        $log.WriteLog("Configurações salvas")
    })

    $form.Controls.Add($buttonSalvar)
    $form.ShowDialog() | Out-Null
    $form.Dispose()
}
   
}



# Obter o caminho do diretório atual do script
$scriptPath = $MyInvocation.MyCommand.Path
$scriptDirectory = Split-Path $scriptPath -Parent
$global:txtFilePath = Join-Path $scriptDirectory "config.txt"

# Criar uma instância da classe Configuracoes
$minhasConfiguracoes = [Configuracoes]::new($origem, $destino)

# Editar as configurações
$minhasConfiguracoes.EditarConfiguracoes()

