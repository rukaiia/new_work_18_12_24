<#import "spring.ftl" as spring>
<#macro layout>
    <!doctype html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport"
              content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
              crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
                crossorigin="anonymous"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
        <title>Document</title>
    </head>
    <body>
    <style>
        .navbar {
            background-color: #343a40;
            backdrop-filter: blur(5px);
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .navbar-brand {
            font-size: 1.75rem;
            font-weight: bold;
            color: #f1f1f1;
            letter-spacing: 1px;
        }
        .nav-link {
            color: #f1f1f1;
            font-size: 18px;
            font-weight: 500;
            transition: color 0.3s ease;
        }
        .nav-link:hover {
            color: #d81b60;
        }
        .btn-outline-info {
            color: #f1f1f1;
            border-color: #d81b60;
            font-weight: 500;
            transition: background-color 0.3s ease, color 0.3s ease;
        }
        .btn-outline-info:hover {
            color: #fff;
            background-color: #d81b60;
            border-color: #d81b60;
        }

        .container {
            margin-top: 100px; /* Добавим отступ сверху, чтобы контент не накладывался на navbar */
        }

        @media (max-width: 768px) {
            .navbar-brand {
                font-size: 1.5rem;
            }
            .nav-link {
                font-size: 16px;
            }
        }

        .btn-create {
            background-color: #d81b60;
            color: white;
            font-weight: bold;
            border-radius: 25px;
            padding: 10px 20px;
            text-transform: uppercase;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2);
            transition: background-color 0.3s ease, transform 0.3s ease, box-shadow 0.3s ease;
        }
        .btn-create:hover {
            background-color: #f57c8d;
            transform: translateY(-5px);
            box-shadow: 0 8px 12px rgba(0, 0, 0, 0.3);
        }

        .btn-dark-theme {
            background-color: #333;
            color: #fff;
            font-weight: bold;
            border-radius: 25px;
            padding: 10px 20px;
            text-transform: uppercase;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2);
            transition: background-color 0.3s ease, transform 0.3s ease, box-shadow 0.3s ease;
        }
        .btn-dark-theme:hover {
            background-color: #555;
            transform: translateY(-5px);
            box-shadow: 0 8px 12px rgba(0, 0, 0, 0.3);
        }

        .btn, .nav-link {
            transition: transform 0.2s ease, background-color 0.3s ease;
        }
        .btn:hover, .nav-link:hover {
            transform: scale(1.05);
        }

    </style>

    <!-- Навигационная панель -->
    <nav class="navbar navbar-expand-lg fixed-top mb-4 shadow">
        <div class="container-fluid">
            <a class="navbar-brand" href="/notes">Notion</a>
            <a href="/pomodoro" class="btn btn-dark-theme m-2">Pomodoro</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                    aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse justify-content-center" id="navbarSupportedContent">
                <!-- Навигация для пользователей -->
            </div>

            <#if _csrf??>
                <form action="/logout" method="post">
                    <input type="hidden" name="${(_csrf.parameterName)!'csrf'}"
                           value="${(_csrf.token)!'--no-token--'}"/>
                    <button type="submit" class="btn btn-dark-theme m-2" id="logout">Logout</button>
                </form>
            <#else>
                <a href="/logout" class="btn btn-dark-theme m-2" id="logout">Logout</a>
            </#if>

            <a href="/auth/login" class="btn btn-dark-theme m-2">Login</a>
            <a href="/auth/register" class="btn btn-dark-theme m-2">Register</a>

        </div>
    </nav>

    <!-- Основной контейнер -->
    <div class="container">
        <#nested spring>
    </div>

    </body>
    </html>
</#macro>
