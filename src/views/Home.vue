<template>
<div>
    <div v-if="!selectedQuiz">
        <h1 class="title">Wähle dein Quiz</h1>
        <div id="quizzes">
            <a class="button is-dark" @click="selectQuiz(quiz.id)" :key="quiz.id" v-for="quiz in quizzes">{{quiz.title}}</a>
        </div>
    </div>
    <div v-else>
        <quiz :quiz="selectedQuiz"></quiz>
    </div>
</div>
</template>

<style lang="less" scoped>
.button {
    margin-bottom: 1em;
}
</style>

<script>
import qas from '@/assets/qas.json';
import Quiz from '@/components/Quiz.vue';

export default {
  data() {
    return {
      quizzes: qas,
      selectedQuiz: null
    }
  },
  methods: {
    selectQuiz(id) {
      this.selectedQuiz = qas.filter(qa => qa.id === id)[0];
    }
  },
  components: {
    quiz: Quiz
  }
}
</script>
