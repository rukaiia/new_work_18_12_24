<#import '../layout.ftlh' as layout>
<@layout.layout ; spring>
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Pomodoro Timer</title>
        <style>
            /* Основной стиль страницы */
            body {
                font-family: 'Roboto', sans-serif;
                background: linear-gradient(135deg, #74ebd5, #acb6e5);
                color: #333;
                margin: 0;
                padding: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                flex-direction: column;
                height: 100vh;
                overflow: hidden;
                box-sizing: border-box;
            }

            .timer-container, .settings-container {
                background: rgba(255, 255, 255, 0.9);
                backdrop-filter: blur(10px);
                padding: 40px;
                border-radius: 20px;
                box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
                text-align: center;
                max-width: 400px;
                width: 100%;
                margin: 20px auto;
                transition: transform 0.3s, box-shadow 0.3s;
            }

            .timer-container:hover, .settings-container:hover {
                transform: scale(1.05);
                box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
            }


            /* Контейнер для таймера */
            .timer-container {
                background: rgba(255, 255, 255, 0.9);
                backdrop-filter: blur(10px); /* Размытие фона */
                padding: 40px;
                border-radius: 20px;
                box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
                text-align: center;
                max-width: 400px;
                width: 90%;
                transition: transform 0.3s, box-shadow 0.3s;
            }

            .timer-container:hover {
                transform: scale(1.05);
                box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
            }

            .timer-display {
                font-size: 5rem;
                font-weight: bold;
                color: #16a085;
                margin-bottom: 30px;
                text-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
                animation: pulse 1s infinite;
            }

            @keyframes pulse {
                0%, 100% {
                    color: #16a085;
                }
                50% {
                    color: #1abc9c;
                }
            }

            /* Кнопки управления */
            .buttons button {
                background: linear-gradient(135deg, #16a085, #1abc9c);
                color: white;
                border: none;
                padding: 15px 30px;
                font-size: 1.2rem;
                cursor: pointer;
                border-radius: 12px;
                margin: 10px;
                transition: transform 0.2s, box-shadow 0.3s;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            }

            .buttons button:hover {
                transform: scale(1.1);
                box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
            }

            .buttons button:active {
                transform: scale(0.95);
                box-shadow: 0 3px 8px rgba(0, 0, 0, 0.4);
            }

            /* Настройки */
            .settings-container {
                background: rgba(255, 255, 255, 0.8);
                backdrop-filter: blur(10px);
                padding: 20px;
                margin-top: 40px;
                border-radius: 15px;
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15);
                max-width: 400px;
                width: 90%;
                text-align: center;
                transition: box-shadow 0.3s, transform 0.2s;
            }

            .settings-container:hover {
                transform: scale(1.02);
                box-shadow: 0 15px 30px rgba(0, 0, 0, 0.2);
            }

            .settings-container input {
                font-size: 1.5rem;
                padding: 12px;
                margin: 10px 0;
                border-radius: 8px;
                border: 1px solid #ccc;
                width: 70%;
                transition: border-color 0.3s ease, box-shadow 0.3s;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            }

            .settings-container input:focus {
                border-color: #16a085;
                outline: none;
                box-shadow: 0 6px 15px rgba(0, 0, 0, 0.2);
            }

            .settings-container button {
                background: linear-gradient(135deg, #16a085, #1abc9c);
                color: white;
                border: none;
                padding: 12px 24px;
                font-size: 1.2rem;
                cursor: pointer;
                border-radius: 12px;
                margin-top: 15px;
                transition: transform 0.2s, box-shadow 0.3s;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            }

            .settings-container button:hover {
                transform: scale(1.05);
                box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
            }

            .settings-container button:active {
                transform: scale(0.95);
            }

            /* Адаптивность */
            @media (max-width: 600px) {
                .timer-display {
                    font-size: 4rem;
                }

                .buttons button {
                    padding: 12px 20px;
                    font-size: 1rem;
                }

                .settings-container input {
                    width: 80%;
                }
            }
        </style>
    </head>
    <body>
    <div class="timer-container">
        <div class="timer-display">
            <h2>
                <#if minutes < 10>0</#if>${minutes}<#if seconds < 10>:0</#if>${seconds}
            </h2>
        </div>

        <div class="buttons">
            <button id="startButton" onclick="startTimer()">Старт</button>
            <button id="pauseButton" style="display:none;" onclick="pauseTimer()">Пауза</button>
            <button id="resetButton" onclick="resetTimer()">Сброс</button>
        </div>
    </div>

    <div class="settings-container">
        <h3>Настройки таймера</h3>
        <form action="/pomodoro/settings" method="POST">
            <#if _csrf??>
                <input type="hidden" name="${(_csrf.parameterName)!'csrf'}"
                       value="${(_csrf.token)!'--no-token--'}"/>
            </#if>
            <label for="workDuration">Время работы (мин.): </label>
            <input type="number" name="workDuration" value="${workDuration}" required min="1">

            <label for="breakDuration">Время перерыва (мин.): </label>
            <input type="number" name="breakDuration" value="${breakDuration}" required min="1">

            <button type="submit">Сохранить настройки</button>
        </form>
    </div>

    <script>
        let minutes = ${minutes};  // Данные из модели (начальное количество минут)
        let seconds = ${seconds};  // Начальные секунды
        let timeLeft = minutes * 60; // Время в секундах
        let timer;

        function formatWithLeadingZero(number) {
            return number < 10 ? '0' + number : number;
        }

        function startTimer() {
            document.getElementById("startButton").style.display = "none";
            document.getElementById("pauseButton").style.display = "inline";

            timer = setInterval(function() {
                if (timeLeft <= 0) {
                    clearInterval(timer);
                    alert("Время работы закончилось!");
                } else {
                    timeLeft--;
                    minutes = Math.floor(timeLeft / 60);
                    seconds = timeLeft % 60;

                    document.querySelector('.timer-display h2').textContent = formatWithLeadingZero(minutes) + ":" + formatWithLeadingZero(seconds);
                }
            }, 1000);
        }

        function pauseTimer() {
            clearInterval(timer);
            document.getElementById("startButton").style.display = "inline";
            document.getElementById("pauseButton").style.display = "none";
        }

        function resetTimer() {
            clearInterval(timer);
            timeLeft = minutes * 60;
            document.querySelector('.timer-display h2').textContent = formatWithLeadingZero(minutes) + ":00";
            document.getElementById("startButton").style.display = "inline";
            document.getElementById("pauseButton").style.display = "none";
        }
    </script>
    </body>
    </html>
</@layout.layout>
