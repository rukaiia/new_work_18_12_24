<#import "../layout.ftlh" as main>
<@main.layout>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>My Notes</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #2d3436; /* Темный фон */
                font-family: 'Segoe UI', sans-serif;
                color: #dfe6e9; /* Светлый текст */
                margin: 0;
                padding: 0;
                transition: all 0.3s ease;
            }

            .container {
                max-width: 960px;
                margin: 50px auto;
                padding: 20px;
                background-color: #1e272e; /* Темный фон для контейнера */
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            }

            h1 {
                color: #74b9ff;
                font-size: 2.5rem;
                font-weight: bold;
                text-align: center;
                margin-bottom: 40px;
                text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.3);
                animation: fadeIn 1s ease-out;
            }

            .btn-create {
                display: inline-block;
                margin-bottom: 20px;
                background-color: #0984e3;
                border: none;
                color: white;
                padding: 10px 20px;
                font-size: 16px;
                font-weight: bold;
                border-radius: 30px;
                text-transform: uppercase;
                transition: background-color 0.3s ease, transform 0.3s ease;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            }

            .btn-create:hover {
                background-color: #74b9ff;
                transform: translateY(-5px);
                box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
            }

            .note-card {
                background-color: #34495e;
                border-radius: 15px;
                box-shadow: 0 8px 15px rgba(0, 0, 0, 0.1);
                padding: 20px;
                overflow: hidden;
                border: 2px solid #2d3436;
                position: relative;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            .note-card:hover {
                transform: scale(1.05);
                box-shadow: 0 12px 25px rgba(0, 0, 0, 0.2);
            }

            .note-title {
                font-size: 1.6rem;
                font-weight: bold;
                color: #74b9ff;
                margin-bottom: 15px;
                text-transform: capitalize;
                animation: slideIn 0.6s ease-out;
            }

            .note-title a {
                text-decoration: none;
                color: inherit;
            }

            .note-title a:hover {
                color: #0984e3;
                text-decoration: underline;
            }

            .note-actions {
                display: flex;
                justify-content: flex-end;
                gap: 10px;
                margin-top: 15px;
            }

            .note-actions button,
            .note-actions form button {
                background-color: #fab1a0;
                color: white;
                border: none;
                padding: 8px 16px;
                font-size: 14px;
                font-weight: bold;
                border-radius: 25px;
                cursor: pointer;
                transition: background-color 0.3s ease, transform 0.3s ease;
            }

            .note-actions button:hover,
            .note-actions form button:hover {
                background-color: #e17055;
                transform: translateY(-3px);
            }

            .note-actions form {
                display: inline-block;
            }

            .card-body p {
                color: #b2bec3;
                font-size: 14px;
                line-height: 1.6;
            }

            /* Центрированная фильтрация */
            .filter-links {
                display: flex;
                justify-content: center;
                margin-bottom: 30px;
            }

            .filter-links a {
                color: #74b9ff;
                font-weight: bold;
                text-decoration: none;
                padding: 10px 20px;
                border-radius: 30px;
                margin: 0 10px;
                background-color: #2d3436;
                border: 2px solid #74b9ff;
                transition: background-color 0.3s ease, color 0.3s ease;
            }

            .filter-links a:hover {
                background-color: #74b9ff;
                color: #2d3436;
                transform: translateY(-3px);
            }

            /* Анимация для заголовка */
            @keyframes fadeIn {
                0% { opacity: 0; transform: translateY(-20px); }
                100% { opacity: 1; transform: translateY(0); }
            }

            /* Анимация для заголовков заметок */
            @keyframes slideIn {
                0% { opacity: 0; transform: translateX(-50px); }
                100% { opacity: 1; transform: translateX(0); }
            }

            /* Адаптивность для мобильных */
            @media (max-width: 768px) {
                .note-card {
                    padding: 15px;
                }

                h1 {
                    font-size: 2rem;
                }

                .btn-create {
                    font-size: 14px;
                    padding: 8px 16px;
                }

                .note-title {
                    font-size: 1.4rem;
                }

                .filter-links {
                    font-size: 14px;
                    text-align: center;
                }

                .filter-links a {
                    padding: 5px 10px;
                }
            }

        </style>
    </head>
    <body>
    <div class="container">
        <h1 class="text-center mb-4">My Notes</h1>

        <!-- Фильтрация по центру -->
        <div class="filter-links mb-4">
            <a href="/notes?filter=all" <#if filter == "all">style="background-color: #74b9ff; color: #2d3436;"</#if>>Все</a>
            <a href="/notes?filter=completed" <#if filter == "completed">style="background-color: #74b9ff; color: #2d3436;"</#if>>Выполненные</a>
            <a href="/notes?filter=not_completed" <#if filter == "not_completed">style="background-color: #74b9ff; color: #2d3436;"</#if>>Не выполненные</a>
        </div>

        <a href="/notes/create" class="btn btn-primary btn-create">Create New Note</a>

        <#if _csrf??>
            <input type="hidden" name="${(_csrf.parameterName)!'csrf'}" value="${(_csrf.token)!'--no-token--'}"/>
        </#if>

        <div class="row">
            <#list notes as note>
                <div class="col-md-4 mb-4">
                    <div class="note-card p-4 border rounded shadow-sm">
                        <h3 class="note-title">
                            <a href="/notes/${note.id}/edit" class="text-decoration-none text-dark">${note.title}</a>
                        </h3>

                        <p class="description">${note.content}</p>
                        <p>Создано: ${note.createdDateAsString}</p>
                        <p>Статус: ${note.completed?string("Выполнено", "Не выполнено")}</p>

                        <!-- Кнопка отметки -->
                        <form method="post" action="/notes/${note.id}/toggleCompleted">
                            <#if _csrf??>
                                <input type="hidden" name="${(_csrf.parameterName)!'csrf'}" value="${(_csrf.token)!'--no-token--'}"/>
                            </#if>
                            <button type="submit" class="btn btn-info">
                                ${note.completed?string("Снять отметку", "Отметить как выполненное")}
                            </button>
                        </form>

                        <div class="note-actions mt-3">
                            <form action="/notes/${note.id}/delete" method="post">
                                <#if _csrf??>
                                    <input type="hidden" name="${(_csrf.parameterName)!'csrf'}" value="${(_csrf.token)!'--no-token--'}"/>
                                </#if>
                                <button type="submit" class="btn btn-danger btn-sm">Удалить</button>
                            </form>
                        </div>
                    </div>
                </div>
            </#list>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    </body>
    </html>
</@main.layout>
