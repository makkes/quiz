<template>
  <div v-if="quiz && quiz.qas && quiz.qas.length > 0" class="cards">
    <h1 class="title">{{quiz.title}}</h1>
    <div>gewusst: {{remembered}}, nicht gewusst: {{notKnown}}</div>
      <flashcard v-if="!finished"
        v-hammer:swipe="onSwipe"
        class="fcard"
        ref="card"
        :front="quiz.qas[current].q"
        :back="quiz.qas[current].a"></flashcard>
      <div v-else>
        <h1 class="title">Das war's</h1>
        <h2 class="subtitle">Du hast {{remembered}} {{remembered===1 ? "Antwort" : "Antworten"}} gewusst, das sind {{rememberedPct}}%.</h2>
        <h2><a class="button is-dark" @click="restart">Nochmal</a></h2>
      </div>
  </div>
</template>

<style lang="less" scoped>
@media screen and(max-width:600px) {
  .card {
    width: 100%;
  }
}
</style>

<script>
import Flashcard from '../components/Flashcard.vue';

export default {
  props: {
    quiz: Object
  },
  data() {
    return {
      current: 0,
      remembered: 0,
      notKnown: 0,
      finished: false
    };
  },
  computed: {
    rememberedPct: function() {
      return Math.round(this.remembered / this.quiz.qas.length * 100);
    }
  },
  methods: {
    onSwipe(ev) {
      if (ev.direction === 8) { // up
        this.remembered += 1;
        this.showNextCard();
      } else if (ev.direction === 16) { // down
        this.notKnown += 1;
        this.showNextCard();
      }
    },
    restart() {
      this.current = 0;
      this.finished = false;
      this.remembered = 0;
      this.notKnown = 0;
    },
    showNextCard() {
      if (this.current === this.quiz.qas.length - 1) {
        this.finished = true;
        var pastScores = window.localStorage.getItem('scores:' + this.quiz.id);
        if (pastScores) {
          pastScores = JSON.parse(pastScores);
        } else {
          pastScores = [];
        }
        pastScores.push([this.remembered, this.notKnown]);
        window.localStorage.setItem('scores:' + this.quiz.id, JSON.stringify(pastScores));
      } else {
        this.current += 1;
      }
    },
    showPreviousCard() {
      this.current =
        this.current === 0 ? this.quiz.qas.length - 1 : this.current - 1;
    }
  },
  created: function() {
    document.addEventListener('keypress', ev => {
      if (this.finished) {
        return;
      }
      if (ev.key === 'ArrowRight') {
        this.showNextCard();
      } else if (ev.key === 'ArrowUp') {
        this.remembered += 1;
        this.showNextCard();
      } else if (ev.key === 'ArrowDown') {
        this.notKnown += 1;
        this.showNextCard();
      } else if (ev.key === ' ') {
        this.$refs.card.toggle();
      }
    });
  },
  components: {
    Flashcard
  }
};
</script>
