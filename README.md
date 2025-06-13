# Kittygram Final 

## Струкрура репозитория

`.github` - GitHub workflows

`infra` - Terraform, включая конфигурацию создания сервера (используется Yandex Cloud)

`backend`, `frontend` - приложение
 
`nginx` - Nginx

`docker-compose.production.yml` - файл для развертывания приложения, используя Docker

`tests`, `tests.yml` - автотесты

## Используемые автоматизации
- Проверка кода Django
- Сборка и загрузка образов Docker
- Автоматическое развертывание сервера
- Автоматические тесты
- Уведомления в Telegram

## Настройка и установка приложения

### Шаг 1 - добавление secrets для GitHub Actions

Создайте и заполните:

**Docker**:
`DOCKER_LOGIN`, `DOCKER_PASSWORD` - ваши данные для доступа к dockerhub

**Yandex Cloud**: `YC_CLOUD_ID` - id вашего cloud, `YC_FOLDER_ID` - id вашей папки, `YC_KEY_JSON` - base64 encoded ваш authorized_key.json, `ACCESS_KEY` - ключ id для вашего bucket, созданного в Yandex Cloud, `SECRET_KEY` - secret вашего bucket

**Сервер**:
`SERVER_SSH_KEY` - приватный ключ, `SSH_KEY` - публичный ключ, `SERVER_HOST` - IP сервера, сюда можно вставить значение из Terraform, `SERVER_LOGIN` - можно просто использовать `ubuntu`


**Проект**:
`POSTGRES_DB`, `POSTGRES_HOST`, `POSTGRES_PORT`, `POSTGRES_USER`, `POSTGRES_PASSWORD` - данные для доступа к Postgres, в качестве `POSTGRES_DB` можно просто использовать контейнер `kittygram-postgres-db`

**Уведомления**:
`TG_TOKEN` - токен вашего бота, созданного через  Botfather. `TG_TO` - id канала, можно получить из JSON по ссылке `http://api.telegram.org/bot<ваш_токен>/getUpdates`

### Шаг 2 - запустите Terraform workflow в GitHub actions

Возможные варианты запуска: `plan`, `apply`, `destroy`. Соответственно, планирование, создание сервера и удаление сервера.
После использования команды `apply` вы получите IP адрес созданного сервера, полностью готового к работе. Этот IP можно исползовать в `SERVER_HOST`, если запустить Kittygram workflow, приложение будет развернуто на этом сервере. Дополнительных настроек не требуется.

### Шаг 3 - запустите Kittygram workflow. 
Этот workflow будет запускаться при push в репозиторий и также возможен ручной запуск.


## Готово!
Ваш сервер будет доступен по адресу http://<SERVER_HOST>/

### Спасибо за внимание! 
Вопросы можно задать в Telegram @orionisman