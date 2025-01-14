# Nome do repositório
$repoName = "MinhaAppBlazor"

# Publicação do projeto
Write-Host "Publicando projeto Blazor WebAssembly..." -ForegroundColor Cyan
dotnet publish -c Release --output ./docs

# Verifica se o diretório foi criado corretamente
if (Test-Path "./docs/wwwroot") {
    # Movendo arquivos da wwwroot para a raiz
    Write-Host "Movendo arquivos da wwwroot para a pasta docs..." -ForegroundColor Cyan
    Copy-Item ./docs/wwwroot/* ./docs/ -Recurse
    Remove-Item ./docs/wwwroot -Recurse -Force

    # Criando arquivo .nojekyll
    Write-Host "Criando arquivo .nojekyll para desativar Jekyll..." -ForegroundColor Cyan
    New-Item -Path ./docs/.nojekyll -ItemType "File" -Force

    # Adicionando alterações ao Git
    Write-Host "Adicionando alterações ao Git..." -ForegroundColor Cyan
    git add .
    git commit -m "Publicando aplicação Blazor WebAssembly no GitHub Pages"
    git push origin main

    # Exibe a URL
    Write-Host "Acesse sua aplicação em: https://andredarcie.github.io/$repoName/" -ForegroundColor Green
} else {
    Write-Host "Erro: Pasta 'docs/wwwroot' não foi gerada. Verifique se o build foi executado corretamente." -ForegroundColor Red
}