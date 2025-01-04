<#import "../layout.ftlh" as main>
<@main.layout>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Abstract Details</title>
        <link rel="stylesheet" href="/css/style.css">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    </head>
    <body>
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f5f7fb;
            color: #333;
            margin: 0;
            padding: 0;
            line-height: 1.6;
        }

        .container {
            max-width: 1000px;
            margin: 50px auto;
            padding: 40px;
            background-color: #ffffff;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }

        .container:hover {
            box-shadow: 0 15px 45px rgba(0, 0, 0, 0.2);
            transform: translateY(-5px);
        }

        header h1 {
            text-align: center;
            color: #6c5ce7;
            font-size: 36px;
            margin-bottom: 20px;
            font-weight: 700;
        }

        h2 {
            color: #333;
            font-size: 28px;
            font-weight: 500;
            margin-bottom: 15px;
        }

        .post-details {
            background-color: #ffffff;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
            transition: all 0.3s ease;
        }

        .post-details:hover {
            transform: translateY(-4px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.2);
        }

        .content p {
            margin-bottom: 20px;
            font-size: 16px;
            color: #555;
        }

        .status span {
            font-weight: bold;
            font-size: 16px;
        }

        .completed {
            color: #2ecc71;
        }

        .not-completed {
            color: #e74c3c;
        }

        .author {
            font-style: italic;
            color: #555;
            margin-top: 20px;
        }

        .error-message {
            color: #e74c3c;
            font-size: 18px;
            text-align: center;
            font-weight: bold;
            margin-top: 20px;
        }

        .btn {
            display: inline-block;
            padding: 12px 30px;
            background-color: #6c5ce7;
            color: white;
            font-weight: 500;
            font-size: 16px;
            border-radius: 5px;
            text-decoration: none;
            transition: background-color 0.3s ease, transform 0.3s ease;
        }

        .btn:hover {
            background-color: #5e4cdb;
            transform: translateY(-3px);
        }

        footer {
            text-align: center;
            font-size: 14px;
            color: #777;
            margin-top: 40px;
        }

        footer p {
            margin: 0;
        }

        .container {
            animation: fadeIn 1s ease-in;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }
    </style>

    <div class="container">
        <header>
            <h1>Конспект</h1>
        </header>

        <#if post??>
            <div class="post-details">
                <h2>${post.title}</h2>
                <p><strong>Created:</strong> ${post.createdDateAsString}</p>
                <div class="content">
                    <strong>Content:</strong>
                    <p>${post.content}</p>
                </div>
                <div class="status">
                    <strong>Status:</strong>
                    <#if post.completed>
                        <span class="completed">Завершена</span>
                    <#else>
                        <span class="not-completed">В процессе</span>
                    </#if>
                </div>

                <#if post.user??>
                    <div class="author">
                        <strong>Author:</strong> ${post.user.email}
                    </div>
                </#if>
            </div>
        <#else>
            <p class="error-message">abstract not found.</p>
        </#if>

        <div class="navigation">
            <a href="/abstracts" class="btn">Back to all abstracts</a>
        </div>
    </div>

    <footer>
        <p>&copy; 2024 Notion. All rights reserved.</p>
    </footer>

    </body>
    </html>
</@main.layout>
