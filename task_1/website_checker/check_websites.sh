#!/bin/bash

# Определяем массив с URL сайтов для проверки
websites=("https://google.com" "https://facebook.com" "https://twitter.com")

# Имя лог-файла
log_file="website_status.log"

# Очищаем лог-файл перед записью
> "$log_file"

# Перебираем все сайты в массиве
for site in "${websites[@]}"; do
    # Отправляем запрос с помощью curl и извлекаем только HTTP статус-код
    http_code=$(curl -o /dev/null -s -w "%{http_code}" -L "$site")

    # Проверяем статус-код и записываем результат в лог-файл
    if [ "$http_code" -eq 200 ]; then
        echo "$site is UP" | tee -a "$log_file"
    else
        echo "$site is DOWN (HTTP Status: $http_code)" | tee -a "$log_file"
    fi
done

# Выводим сообщение о завершении
echo "Результаты проверки записаны в файл $log_file"
