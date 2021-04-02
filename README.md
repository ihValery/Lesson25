# Lesson25-TDD на шаг ближе к чистому коду

Создаем приложение на основе тестов
 - 05. TaskDevelopmentWithTDD. Первые тесты для структуры (Создание - Запись - Дата)
 - 06. TaskLocationProperty. Создали вложенную структуру с GEO данными (Проверили инициализацию - проваливали тесты)
 - 07. TaskManager. Добавление, удаление, чек тасков. (Добавление уникальной Task'ки - !tasks.contains(task) - время записываешься с наносекундами!)(Переопределение протокола Equatable - сравнивание моделей (исключили время)) 3 части
 - 10. TaskListViewController. Установили объект DataProvider: NSObject. (Назначили его Delegate и DataSource)(Но сначала тесты) 2 части
 - 12. DataProvider. Добрались до DataSource Реализовали стандартные методы после написания тестов. (numberOfSections - numberOfRowsInSection - cellForRowAt)
 - 14. Theory of Test Doubles. Тесты двойников. (Fake - объекты имеют фактическую реализацию с реальным объектом, но обычно эта реализация упрощена) (Stub - объекты, представляющие из себя заготовки объектов на запросы. Это являеться их основной задачей) (Mock - объекты, которые проверяют вызываются ли определенные методы или устанавливаются какие-либо свойства, когда что-то происходит в вашем приложении)
 - 15. MockTableView. Подменили наш tableView - MockTableView. (Дали ему свойство и смогли проверить переиспользуется ли ячейка)
 - 16. MockTaskCell. Подменили нашу ячейку. (Проверка срабатывает ли в первой секции метод configure(withTask task: Task)) + CellForRow method modification. Тест проходит в любой секции.
 - 19. Done & Undone button name tests. Заменили title кнопки delete. (Отработали тесты что в зависимости от секции кнопка меняет имя) (titleForDeleteConfirmationButtonForRowAt)
 - 20. Check & Unckeck functionality. Проверка что tasks могут бегать из секции в секцию )))

Схема и сущности

<a href="https://ibb.co/sV8r9qg"><img src="https://i.ibb.co/RDRWTcg/Lesson25.jpg" alt="Lesson25" border="0"></a>
