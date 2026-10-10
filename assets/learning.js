(() => {
  const quizzes = document.querySelectorAll('.interactive-quiz');

  quizzes.forEach((quiz) => {
    const questions = [...quiz.querySelectorAll('.quiz-question')];
    const score = quiz.querySelector('.quiz-score');

    quiz.addEventListener('submit', (event) => {
      event.preventDefault();
      let correct = 0;

      questions.forEach((question) => {
        const answer = question.dataset.answer;
        const selected = question.querySelector('input:checked');
        const feedback = question.querySelector('.quiz-feedback');
        const isCorrect = selected && selected.value === answer;

        question.classList.remove('is-correct', 'is-incorrect', 'is-unanswered');
        if (!selected) {
          question.classList.add('is-unanswered');
          feedback.textContent = 'Selecciona una opción para revisar esta pregunta.';
        } else if (isCorrect) {
          correct += 1;
          question.classList.add('is-correct');
          feedback.textContent = feedback.dataset.correct;
        } else {
          question.classList.add('is-incorrect');
          feedback.textContent = feedback.dataset.incorrect;
        }
        feedback.hidden = false;
      });

      score.textContent = `Práctica: ${correct} de ${questions.length}`;
      score.classList.toggle('score-complete', correct === questions.length);
    });
  });
})();
