
<#import "../layout.ftlh" as main>
<@main.layout>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Edit Note</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background: linear-gradient(135deg, #2c3e50, #34495e);
                font-family: 'Segoe UI', sans-serif;
                color: #ecf0f1;
                margin: 0;
                padding: 0;
            }

            .container {
                max-width: 600px;
                margin: 50px auto;
                background: #1e2a3a;
                border-radius: 15px;
                box-shadow: 0 8px 15px rgba(0, 0, 0, 0.5);
                padding: 30px;
                transition: all 0.3s ease;
            }

            .container:hover {
                box-shadow: 0 12px 25px rgba(0, 0, 0, 0.7);
            }

            h1 {
                font-size: 2rem;
                color: #8e44ad;
                text-align: center;
                margin-bottom: 20px;
                font-weight: bold;
                text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
            }

            label {
                font-weight: bold;
                color: #bdc3c7;
                margin-bottom: 5px;
                display: block;
            }

            input[type="text"], textarea {
                width: 100%;
                border: 1px solid #7f8c8d;
                border-radius: 10px;
                padding: 10px;
                font-size: 16px;
                background-color: #34495e;
                color: #ecf0f1;
                transition: border-color 0.3s ease, box-shadow 0.3s ease;
            }

            input[type="text"]:focus, textarea:focus {
                border-color: #8e44ad;
                box-shadow: 0 0 8px rgba(142, 68, 173, 0.6);
                outline: none;
            }

            textarea {
                resize: none;
            }


            .btn-primary {
                background-color: #8e44ad;
                border: none;
                font-size: 16px;
                font-weight: bold;
                padding: 10px 20px;
                border-radius: 30px;
                transition: background-color 0.3s ease, transform 0.3s ease;
                display: block;
                margin: 20px auto 0;
            }

            .btn-primary:hover {
                background-color: #9b59b6;
                transform: translateY(-3px);
            }

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
        <h1>Edit Note</h1>
        <form action="/notes/${note.id}" method="post">
            <#if _csrf??>
                <input type="hidden" name="${(_csrf.parameterName)!'csrf'}"
                       value="${(_csrf.token)!'--no-token--'}"/>
            </#if>
            <input type="hidden" name="_method" value="put">
            <div class="mb-3">
                <label for="title" class="form-label">Title</label>
                <input type="text" id="title" name="title" class="form-control" value="${note.title}" required>
            </div>
            <div class="mb-3">
                <label for="content" class="form-label">Content</label>
                <textarea id="content" name="content" class="form-control" rows="5" required>${note.content}</textarea>
            </div>
            <button type="submit" class="btn btn-primary">Save Changes</button>
        </form>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    </body>
    </html>
</@main.layout>
