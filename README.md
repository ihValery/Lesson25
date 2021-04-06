# Lesson25-TDD на шаг ближе к чистому коду

Создаем приложение на основе тестов
 - 05. TaskDevelopmentWithTDD. Первые тесты для структуры (Создание - Запись - Дата)
 - 06. TaskLocationProperty. Создали вложенную структуру с GEO данными (Проверили инициализацию - проваливали тесты)
 - 07. TaskManager. Добавление, удаление, чек тасков. (Добавление уникальной Task'ки - !tasks.contains(task) - время записываешься с наносекундами!)(Переопределение протокола Equatable - сравнивание моделей (исключили время)) 3 части
 - 10. TaskListViewController. Установили объект DataProvider: NSObject. (Назначили его Delegate и DataSource)(Но сначала тесты) 2 части
 - 12. DataProvider. Добрались до DataSource Реализовали стандартные методы после написания тестов. (numberOfSections - numberOfRowsInSection - cellForRowAt)
 - 14. TheoryOfTestDoubles. Тесты двойников. (Fake - объекты имеют фактическую реализацию с реальным объектом, но обычно эта реализация упрощена) (Stub - объекты, представляющие из себя заготовки объектов на запросы. Это являеться их основной задачей) (Mock - объекты, которые проверяют вызываются ли определенные методы или устанавливаются какие-либо свойства, когда что-то происходит в вашем приложении)
 - 15. MockTableView. Подменили наш tableView - MockTableView. (Дали ему свойство и смогли проверить переиспользуется ли ячейка)
 - 16. MockTaskCell. Подменили нашу ячейку. (Проверка срабатывает ли в первой секции метод configure(withTask task: Task)) + CellForRow method modification. Тест проходит в любой секции.
 - 19. DoneAndUndoneButtonNameTests. Заменили title кнопки delete. (Отработали тесты что в зависимости от секции кнопка меняет имя) (titleForDeleteConfirmationButtonForRowAt)
 - 20. CheckAndUnckeckFunctionality. Проверка что tasks могут бегать из секции в секцию )))
 - 21. CheckTitleLabelInCell. Проверка на Находиться ли titleLabel ячейки внутри cell.contentView (isDescendant) + LocationLabel
 - 22. CellConfigureTests. Реализовали тесты и функционал для заполнения ячейки. (Title - Date (через DateFormatter) - Location)
 - 23. DoneTaskStyle. Сконфигурировали ячейку под секции. (NSAttributedString - запоминаем пользуемся) (Выполненая задача будет зачеркнута)
 - 24. DetailViewControllerElements. Создали DetailViewController (Со всеми Label’ми) (Подключили MapKit)
 - 25. TestingLabelsOnDetailViewController . Тесты для всех лейблов в DetailViewController. (coordinate - location - date(timeIntervalSince1970))
 - 26. DateLabelAndMapViewTests.  Разобрались как работать с датами. (Проверили что даты отображаются в нужном формате. Разобрались как mapView отображает необходимую нам область)
 - 27. ControllerForNewTasks.  Создали новый InputTaskViewController. (Накидали UITextField и Button) (Сначала тест что такое свойство есть, а следом тест что оно лежит на view)
 - 29. GettingCoordinatesFromGeocoder. Создали мини проек Geocoder (Optional(53.896196) Optional(27.5503093)) (Реализовали БОЛЬШОЙ тест при заполнении новой task’и)
 - 30. TestGeocoderReturnedCoordinate. Expectation - ожидание (метод для создания экземпляров XCTestExpectation, которые могут быть выполнены после завершения асинхронных задач в ваших тестах. Вызовите метод ожидания fulfill(), когда асинхронная задача в вашем тесте завершится.) Без интернета тест проваливается )))
 - 31. TestHostURLComponent. Написали тест который проверяет правильность host в нашем url (Фейковые данные)
 - 32. QueryItemsTest. Зафейлится если последовательность будет нарушена, разобъем на два.
 - 33. TokenAvailabilityTest. Генерируется token при успешной авторизации. (Общая картина выливаеться и связей token -> data -> completionHandler -> DataTask -> urlSession)
 - 34. JSONTests. Тесты на запросы. (При успешном входе в систему создается токен. - Вход в систему не удался. Ошибка возврата JSON. - Ошибка входа в систему, когда данные равны нулю. - Вход в систему, когда ошибка ответа возвращает ошибку.)
 - 35. AddNewTaskButtonTests. (Проверили существует ли кнопка и переходим ли мы по ней в новое окно для ввода)

Схема и сущности

<a href="https://ibb.co/sV8r9qg"><img src="https://i.ibb.co/RDRWTcg/Lesson25.jpg" alt="Lesson25" border="0"></a>
