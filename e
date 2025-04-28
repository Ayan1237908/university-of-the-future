<!DOCTYPE html>
<html lang="ru">
<head>
  <meta charset="UTF-8">
  <title>Физическая викторина PRO</title>
  <style>
    body {
      font-family: 'Arial', sans-serif;
      text-align: center;
      padding: 20px;
      background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
      min-height: 100vh;
      margin: 0;
      transition: all 0.5s;
    }
    
    h1 {
      color: #2c3e50;
      text-shadow: 1px 1px 3px rgba(0,0,0,0.2);
      margin-bottom: 30px;
      animation: fadeIn 1s ease-in;
    }
    
    #quiz-container {
      max-width: 800px;
      margin: 0 auto;
    }
    
    #quiz {
      background: white;
      border-radius: 15px;
      padding: 25px;
      box-shadow: 0 10px 25px rgba(0,0,0,0.1);
      margin-bottom: 20px;
      transition: all 0.3s;
    }
    
    .question {
      font-size: 22px;
      margin-bottom: 25px;
      color: #34495e;
      min-height: 60px;
      display: flex;
      align-items: center;
      justify-content: center;
      animation: slideIn 0.5s ease-out;
    }
    
    .answers {
      display: flex;
      flex-direction: column;
      gap: 12px;
    }
    
    .answers button {
      padding: 12px 20px;
      font-size: 16px;
      border: none;
      border-radius: 8px;
      background: #3498db;
      color: white;
      cursor: pointer;
      transition: all 0.3s;
      box-shadow: 0 3px 6px rgba(0,0,0,0.1);
      animation: fadeIn 0.5s ease-in;
    }
    
    .answers button:hover {
      background: #2980b9;
      transform: translateY(-2px);
      box-shadow: 0 5px 10px rgba(0,0,0,0.2);
    }
    
    .answers button:active {
      transform: translateY(0);
    }
    
    .timer {
      font-size: 18px;
      margin: 15px 0;
      color: #e74c3c;
      font-weight: bold;
      animation: pulse 1s infinite;
    }
    
    .result {
      margin-top: 20px;
      font-size: 20px;
      font-weight: bold;
      min-height: 30px;
      transition: all 0.3s;
    }
    
    .score {
      margin-top: 30px;
      font-size: 24px;
      color: #2c3e50;
      animation: fadeIn 1s;
    }
    
    #controls {
      margin: 20px auto;
      display: flex;
      gap: 10px;
      justify-content: center;
      flex-wrap: wrap;
    }
    
    #controls button {
      padding: 8px 15px;
      border: none;
      border-radius: 5px;
      color: white;
      cursor: pointer;
      transition: all 0.3s;
    }
    
    #progress {
      width: 100%;
      background: #eee;
      border-radius: 5px;
      margin: 10px 0;
      height: 10px;
    }
    
    #progress-bar {
      height: 100%;
      width: 0%;
      background: #3498db;
      border-radius: 5px;
      transition: width 0.5s;
    }
    
    #leaderboard {
      background: white;
      padding: 15px;
      border-radius: 10px;
      margin: 20px auto;
      box-shadow: 0 3px 10px rgba(0,0,0,0.1);
      max-width: 500px;
    }
    
    #player-name {
      margin-top: 20px;
      display: none;
    }
    
    #player-name input {
      padding: 8px;
      border: 1px solid #ddd;
      border-radius: 5px;
      margin-right: 10px;
    }
    
    /* Анимации */
    @keyframes fadeIn {
      from { opacity: 0; }
      to { opacity: 1; }
    }
    
    @keyframes slideIn {
      from { transform: translateY(20px); opacity: 0; }
      to { transform: translateY(0); opacity: 1; }
    }
    
    @keyframes pulse {
      0% { transform: scale(1); }
      50% { transform: scale(1.05); }
      100% { transform: scale(1); }
    }
    
    @keyframes shake {
      0%, 100% { transform: translateX(0); }
      10%, 30%, 50%, 70%, 90% { transform: translateX(-5px); }
      20%, 40%, 60%, 80% { transform: translateX(5px); }
    }
    
    @keyframes bounce {
      0%, 100% { transform: translateY(0); }
      50% { transform: translateY(-10px); }
    }
    
    .correct {
      background: #2ecc71 !important;
      animation: bounce 0.5s;
    }
    
    .wrong {
      background: #e74c3c !important;
      animation: shake 0.5s;
    }
    
    .time-up {
      color: #e67e22;
    }
    
    .dark-theme {
      background: #2c3e50 !important;
      color: #ecf0f1;
    }
    
    .dark-theme #quiz,
    .dark-theme #leaderboard {
      background: #34495e;
      color: #ecf0f1;
    }
    
    .dark-theme .question {
      color: #ecf0f1;
    }
    
    .dark-theme .score {
      color: #ecf0f1;
    }
    
    @media (max-width: 600px) {
      .question {
        font-size: 18px;
      }
      
      .answers button {
        padding: 10px 15px;
        font-size: 14px;
      }
    }
  </style>
</head>
<body>

<div id="quiz-container">
  <h1>🎓 Физическая викторина PRO</h1>
  
  <div id="progress">
    <div id="progress-bar"></div>
  </div>
  
  <div id="quiz">
    <div class="question" id="question"></div>
    <div class="answers" id="answers"></div>
    <div class="timer" id="timer"></div>
    <div class="result" id="result"></div>
  </div>
  
  <div id="controls">
    <button id="hint" onclick="useHint()" style="background: #f39c12;">Подсказка 50/50</button>
    <button onclick="toggleMusic()" style="background: #9b59b6;">
      <span id="music-icon">🔈</span> Музыка
    </button>
    <button onclick="document.body.classList.toggle('dark-theme')" style="background: #34495e;">🌓 Тема</button>
  </div>
  
  <div class="score" id="score"></div>
  
  <div id="player-name">
    <input type="text" id="name-input" placeholder="Ваше имя">
    <button onclick="saveResult()" style="background: #2ecc71;">Сохранить результат</button>
  </div>
  
  <div id="leaderboard"></div>
</div>

<!-- Звуковые эффекты -->
<audio id="correct-sound" src="https://assets.mixkit.co/sfx/preview/mixkit-correct-answer-tone-2870.mp3" preload="auto"></audio>
<audio id="wrong-sound" src="https://assets.mixkit.co/sfx/preview/mixkit-wrong-answer-fail-notification-946.mp3" preload="auto"></audio>
<audio id="time-sound" src="https://assets.mixkit.co/sfx/preview/mixkit-alarm-digital-clock-beep-989.mp3" preload="auto"></audio>
<audio id="bg-music" loop src="https://assets.mixkit.co/music/preview/mixkit-game-show-suspense-waiting-668.mp3" preload="auto"></audio>
<audio id="win-sound" src="https://assets.mixkit.co/sfx/preview/mixkit-achievement-bell-600.mp3" preload="auto"></audio>

<script>
// Данные викторины (12 вопросов)
const quizData = [
  {
    question: "Кто получил первую Нобелевскую премию по физике?", 
    answers: ["Вильгельм Рентген", "Альберт Эйнштейн", "Исаак Ньютон", "Никола Тесла"], 
    correct: "Вильгельм Рентген",
    explanation: "Вильгельм Конрад Рентген получил первую Нобелевскую премию по физике в 1901 году за открытие рентгеновских лучей."
  },
  {
    question: "Эта женщина дважды получила Нобелевскую премию. Кто она?", 
    answers: ["Лиза Мейтнер", "Мария Склодовская-Кюри", "Розалинд Франклин", "Джоселин Белл"], 
    correct: "Мария Склодовская-Кюри",
    explanation: "Мария Кюри получила Нобелевские премии по физике (1903) и химии (1911)."
  },
  {
    question: "Как энергия Солнца достигает Земли?", 
    answers: ["Путём теплопроводности", "Путём конвекции", "Путём излучения", "Путём испарения"], 
    correct: "Путём излучения",
    explanation: "Солнечная энергия передаётся через космическое пространство преимущественно путём электромагнитного излучения."
  },
  {
    question: "Как называется линия, вдоль которой движется тело?", 
    answers: ["Радиус", "Траектория", "Вектор", "Ось"], 
    correct: "Траектория",
    explanation: "Траектория - это линия, по которой движется тело в пространстве с течением времени."
  },
  {
    question: "Как называется элементарная частица с положительным зарядом?", 
    answers: ["Электрон", "Нейтрон", "Протон", "Дейтрон"], 
    correct: "Протон",
    explanation: "Протон - стабильная элементарная частица с положительным электрическим зарядом +1e."
  },
  {
    question: "Какое физическое явление на обложке Pink Floyd \"The Dark Side of the Moon\"?", 
    answers: ["Поляризация", "Дисперсия", "Интерференция", "Рефракция"], 
    correct: "Дисперсия",
    explanation: "На обложке изображён спектр света, разложенный призмой - пример дисперсии света."
  },
  {
    question: "Единица измерения работы в системе СИ?", 
    answers: ["Ватт", "Джоуль", "Ньютон", "Паскаль"], 
    correct: "Джоуль",
    explanation: "Джоуль (Дж) - единица измерения работы, энергии и количества теплоты в системе СИ."
  },
  {
    question: "Как называется явление сохранения скорости тела при отсутствии внешних сил?", 
    answers: ["Инерция", "Импульс", "Ускорение", "Трение"], 
    correct: "Инерция",
    explanation: "Инерция - свойство тела сохранять состояние покоя или равномерного прямолинейного движения при отсутствии внешних воздействий."
  },
  {
    question: "Прибор для создания звука определённой частоты?", 
    answers: ["Резонатор", "Камертон", "Циклотрон", "Позитрон"], 
    correct: "Камертон",
    explanation: "Камертон - устройство для фиксации и воспроизведения эталонной высоты звука."
  },
  {
    question: "Самая маленькая мера длины среди перечисленных?", 
    answers: ["Нанометр", "Ангстрем", "Микрометр", "Миллиметр"], 
    correct: "Ангстрем",
    explanation: "1 ангстрем = 0.1 нанометра = 10^-10 метра."
  },
  {
    question: "Какой тепловой процесс сопровождается понижением температуры?", 
    answers: ["Конденсация", "Плавление", "Испарение", "Сублимация"], 
    correct: "Испарение",
    explanation: "При испарении жидкость поглощает тепло, что приводит к понижению температуры."
  },
  {
    question: "Что такое диэлектрик для физика?", 
    answers: ["Проводник", "Полупроводник", "Изолятор", "Суперпроводник"], 
    correct: "Изолятор",
    explanation: "Диэлектрик (изолятор) - вещество, плохо проводящее электрический ток."
  }
];

// Переменные игры
let currentQuestion = 0;
let score = 0;
let timer;
let timeLeft = 15;
let bgMusicPlaying = false;
let hintsUsed = 0;

// Элементы звуков
const correctSound = document.getElementById('correct-sound');
const wrongSound = document.getElementById('wrong-sound');
const timeSound = document.getElementById('time-sound');
const bgMusic = document.getElementById('bg-music');
const winSound = document.getElementById('win-sound');

// Инициализация игры
function initGame() {
  currentQuestion = 0;
  score = 0;
  hintsUsed = 0;
  document.getElementById('player-name').style.display = 'none';
  document.getElementById('score').innerHTML = '';
  loadQuestion();
}

// Загрузка вопроса
function loadQuestion() {
  const q = quizData[currentQuestion];
  document.getElementById('question').innerText = q.question;
  
  const answersDiv = document.getElementById('answers');
  answersDiv.innerHTML = '';

  q.answers.forEach((answer, index) => {
    const btn = document.createElement('button');
    btn.innerText = answer;
    btn.onclick = () => selectAnswer(answer);
    btn.style.animationDelay = `${index * 0.1}s`;
    answersDiv.appendChild(btn);
  });
  
  document.getElementById('result').innerText = '';
  document.getElementById('result').style.color = '';
  document.getElementById('hint').disabled = false;
  
  // Обновление прогресс-бара
  document.getElementById('progress-bar').style.width = `${(currentQuestion / quizData.length) * 100}%`;
  
  startTimer();
  
  // Плавное появление
  document.getElementById('quiz').style.opacity = 0;
  setTimeout(() => {
    document.getElementById('quiz').style.opacity = 1;
  }, 300);
}

// Таймер
function startTimer() {
  clearInterval(timer);
  timeLeft = 15;
  updateTimerDisplay();
  document.getElementById('timer').classList.remove('time-up');
  
  timer = setInterval(() => {
    timeLeft--;
    updateTimerDisplay();
    
    if (timeLeft <= 5) {
      document.getElementById('timer').classList.add('time-up');
    }
    
    if (timeLeft <= 0) {
      clearInterval(timer);
      timeSound.play();
      checkAnswer(null);
    }
  }, 1000);
}

function updateTimerDisplay() {
  document.getElementById('timer').innerHTML = 
    `⏱️ Осталось времени: <span style="font-size:1.2em">${timeLeft}</span> сек`;
}

// Выбор ответа
function selectAnswer(answer) {
  clearInterval(timer);
  const buttons = document.querySelectorAll('.answers button');
  
  buttons.forEach(btn => {
    btn.disabled = true;
    if (btn.innerText === quizData[currentQuestion].correct) {
      btn.classList.add('correct');
    } else if (btn.innerText === answer && answer !== quizData[currentQuestion].correct) {
      btn.classList.add('wrong');
    }
  });
  
  checkAnswer(answer);
}

// Проверка ответа
function checkAnswer(answer) {
  const q = quizData[currentQuestion];
  const resultDiv = document.getElementById('result');
  
  if (answer === q.correct) {
    correctSound.play();
    resultDiv.innerHTML = "✅ <strong>Правильно!</strong> +1 балл<br><small>" + q.explanation + "</small>";
    resultDiv.style.color = "#2ecc71";
    score++;
    document.body.style.background = "linear-gradient(135deg, #f5f7fa 0%, #a1c4fd 100%)";
  } else if (answer === null) {
    resultDiv.innerHTML = `⌛ <strong>Время вышло!</strong> Правильный ответ: ${q.correct}<br><small>${q.explanation}</small>`;
    resultDiv.style.color = "#e67e22";
    document.body.style.background = "linear-gradient(135deg, #f5f7fa 0%, #ffecd2 100%)";
  } else {
    wrongSound.play();
    resultDiv.innerHTML = `❌ <strong>Неправильно!</strong> Правильный ответ: ${q.correct}<br><small>${q.explanation}</small>`;
    resultDiv.style.color = "#e74c3c";
    document.body.style.background = "linear-gradient(135deg, #f5f7fa 0%, #ff9a9e 100%)";
  }
  
  setTimeout(() => {
    document.body.style.background = "linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%)";
    currentQuestion++;
    if (currentQuestion < quizData.length) {
      loadQuestion();
    } else {
      endQuiz();
    }
  }, 2500);
}

// Подсказка 50/50
function useHint() {
  const q = quizData[currentQuestion];
  const wrongAnswers = q.answers.filter(a => a !== q.correct);
  const randomWrong = wrongAnswers[Math.floor(Math.random() * wrongAnswers.length)];
  
  document.querySelectorAll('.answers button').forEach(btn => {
    if (btn.innerText !== q.correct && btn.innerText !== randomWrong) {
      btn.disabled = true;
      btn.style.opacity = 0.3;
    }
  });
  
  document.getElementById('hint').disabled = true;
  hintsUsed++;
}

// Завершение викторины
function endQuiz() {
  winSound.play();
  bgMusic.pause();
  
  const quizDiv = document.getElementById('quiz');
  quizDiv.innerHTML = `
    <h2 style="animation: bounce 1s;">🎉 Викторина завершена!</h2>
    <div style="font-size: 20px; margin: 20px 0;">
      Ваш результат: <strong>${score} из ${quizData.length}</strong><br>
      Использовано подсказок: ${hintsUsed}
    </div>
    <div id="result-message" style="font-size: 18px; margin-bottom: 20px;">
      ${getResultMessage(score, quizData.length)}
    </div>
    <button onclick="initGame()" style="
      padding: 12px 25px;
      font-size: 16px;
      background: #3498db;
      color: white;
      border: none;
      border-radius: 8px;
      cursor: pointer;
      margin: 5px;
    ">Пройти ещё раз</button>
  `;
  
  document.getElementById('player-name').style.display = 'block';
  showLeaderboard();
}

// Сообщение с результатом
function getResultMessage(score, total) {
  const percentage = (score / total) * 100;
  
  if (percentage >= 90) return "Отлично! Вы настоящий знаток физики! 🏆";
  if (percentage >= 70) return "Хороший результат! Вы хорошо разбираетесь в физике! 👍";
  if (percentage >= 50) return "Неплохо! Но есть куда расти 📚";
  return "Попробуйте ещё раз! Физика - это интересно! 🔍";
}

// Сохранение результата
function saveResult() {
  const name = document.getElementById('name-input').value.trim();
  if (!name) {
    alert("Пожалуйста, введите ваше имя");
    return;
  }
  
  const results = JSON.parse(localStorage.getItem('quizResults') || '[]');
  results.push({
    name: name,
    score: score,
    total: quizData.length,
    date: new Date().toLocaleString(),
    hints: hintsUsed
  });
  
  localStorage.setItem('quizResults', JSON.stringify(results));
  showLeaderboard();
  document.getElementById('name-input').value = '';
}

// Показать таблицу лидеров
function showLeaderboard() {
  const results = JSON.parse(localStorage.getItem('quizResults') || '[]');
  const sorted = results.sort((a,b) => (b.score/b.total) - (a.score/a.total)).slice(0,5);
  
  let html = '<h3>🏆 ТОП-5 игроков:</h3><ol>';
  sorted.forEach(r => {
    html += `<li><strong>${r.name}</strong>: ${r.score}/${r.total} (${r.date})</li>`;
  });
  html += '</ol>';
  
  document.getElementById('leaderboard').innerHTML = html;
}

// Управление музыкой
function toggleMusic() {
  const icon = document.getElementById('music-icon');
  if (bgMusicPlaying) {
    bgMusic.pause();
    icon.textContent = '🔈';
  } else {
    bgMusic.play();
    bgMusic.volume = 0.3;
    icon.textContent = '🔊';
  }
  bgMusicPlaying = !bgMusicPlaying;
}

// Запуск при загрузке
window.onload = function() {
  initGame();
  setTimeout(() => {
    if (confirm("Хотите включить фоновую музыку для атмосферы?")) {
      toggleMusic();
    }
  }, 1000);
};
</script>

</body>
</html>
