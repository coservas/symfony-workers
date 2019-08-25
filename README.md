### Symfony workers

Запуск приложения:
```
git clone https://github.com/coservas/symfony-workers.git
cd symfony-workers
make install
```

Постановка простых задач worker-ам:
```
make add-job
```

Просмотр сведений о выполнении задач worker-ами:
```
make logs c=worker1
make logs c=worker2
```

Изменить количество worker-ов можно в файле docker-compose.yml