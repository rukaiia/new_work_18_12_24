<#import "../layout.ftlh" as main>
<@main.layout>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Create New Note</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            /* Общий темный фон */
            body {
                background: linear-gradient(135deg, #2c3e50, #34495e); /* Градиент от темно-синего к темно-серому */
                font-family: 'Segoe UI', sans-serif;
                color: #ecf0f1; /* Светлый текст */
                margin: 0;
                padding: 0;
            }

            /* Контейнер формы */
            .container {
                max-width: 600px;
                margin: 50px auto;
                background: #2c3e50; /* Темный фон для контейнера */
                border-radius: 15px;
                box-shadow: 0 8px 15px rgba(0, 0, 0, 0.2); /* Легкая тень */
                padding: 30px;
                transition: all 0.3s ease;
            }

            .container:hover {
                box-shadow: 0 12px 20px rgba(0, 0, 0, 0.4); /* Увеличение тени при наведении */
            }

            /* Заголовок формы */
            h1 {
                font-size: 2rem;
                color: #8e44ad; /* Фиолетовый акцент */
                text-align: center;
                margin-bottom: 20px;
                font-weight: bold;
                text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.2);
            }

            /* Метки для полей */
            label {
                font-weight: bold;
                color: #ecf0f1; /* Светлый цвет для меток */
                margin-bottom: 5px;
                display: block;
            }

            /* Поля ввода */
            input[type="text"], textarea {
                width: 100%;
                border: 1px solid #34495e; /* Темная граница */
                border-radius: 10px;
                padding: 10px;
                font-size: 16px;
                color: #ecf0f1; /* Светлый цвет текста */
                background-color: #34495e; /* Темный фон для полей */
                transition: border-color 0.3s ease, box-shadow 0.3s ease;
            }

            input[type="text"]:focus, textarea:focus {
                border-color: #8e44ad; /* Фиолетовый при фокусе */
                box-shadow: 0 0 8px rgba(142, 68, 173, 0.5);
                outline: none;
            }

            textarea {
                resize: none;
            }

            /* Кнопка */
            .btn-primary {
                background-color: #8e44ad; /* Фиолетовый */
                border: none;
                font-size: 16px;
                font-weight: bold;
                padding: 10px 20px;
                border-radius: 30px;
                transition: background-color 0.3s ease, transform 0.3s ease;
                display: block;
                margin: 20px auto 0;
                text-transform: uppercase;
            }

            .btn-primary:hover {
                background-color: #6f2c91; /* Темный фиолетовый */
                transform: translateY(-3px); /* Эффект поднятия */
            }

            /* Анимации для кнопки */
            .btn-primary:active {
                transform: translateY(1px); /* Эффект сжатия при клике */
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.3);
            }

            /* Адаптивность */
            @media (max-width: 768px) {
                .container {
                    padding: 20px;
                }

                h1 {
                    font-size: 1.8rem;
                }

                .btn-primary {
                    font-size: 14px;
                    padding: 8px 16px;
                }
            }
        </style>
    </head>
    <body>
    <div class="container mt-5">
        <h1>Create New Note</h1>
        <form action="/notes" method="post">
            <#if _csrf??>
                <input type="hidden" name="${(_csrf.parameterName)!'csrf'}"
                       value="${(_csrf.token)!'--no-token--'}"/>
            </#if>
            <div class="mb-3">
                <label for="title" class="form-label">Title</label>
                <input type="text" id="title" name="title" class="form-control" required>
            </div>
            <div class="mb-3">
                <label for="content" class="form-label">Content</label>
                <textarea id="content" name="content" class="form-control" rows="5" required></textarea>
            </div>
            <button type="submit" class="btn btn-primary">Create</button>
        </form>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    </body>
    </html>
</@main.layout>
