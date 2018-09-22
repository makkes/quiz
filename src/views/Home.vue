<template>
  <div class="cards">
    <div>gewusst: {{remembered}}, nicht gewusst: {{notKnown}}</div>
    <div v-if="questions.length > 0">
      <flashcard v-if="!finished"
        v-hammer:swipe="onSwipe"
        class="card"
        ref="card"
        :front="questions[current].q"
        :back="questions[current].a"></flashcard>
      <div v-else>
        <h1>Das war's</h1>
        <h2>Du hast {{remembered}} {{remembered===1 ? "Antwort" : "Antworten"}} gewusst, das sind {{rememberedPct}}%.</h2>
        <h2><button @click="restart">Nochmal</button></h2>
      </div>
    </div>
    <div v-else>
      <h1>Lade Fragen...</h1>
    </div>
  </div>
</template>

<style lang="less" scoped>
.card {
  width: 40em;
  margin-left: auto;
  margin-right: auto;
}

@media screen and(max-width:600px) {
  .card {
    width: 100%;
  }
}
</style>

<script>
import Flashcard from '../components/Flashcard.vue';

export default {
  data() {
    return {
      questions: [],
      current: 0,
      remembered: 0,
      notKnown: 0,
      finished: false
    };
  },
  computed: {
    rememberedPct: function() {
      return Math.round(this.remembered / this.questions.length * 100);
    }
  },
  methods: {
    onSwipe(ev) {
      if(ev.direction === 8) { // up
      this.remembered += 1;
      this.showNextCard();
      } else if(ev.direction === 16)  { // down
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
      if (this.current === this.questions.length - 1) {
        this.finished = true;
        var pastScores = window.localStorage.getItem('scores:test');
        if(pastScores) {
          pastScores = JSON.parse(pastScores);
        } else {
          pastScores = [];
        }
        pastScores.push([this.remembered, this.notKnown]);
        window.localStorage.setItem('scores:test', JSON.stringify(pastScores));
      } else {

        this.current += 1;
      }
    },
    showPreviousCard() {
      this.current =
        this.current === 0 ? this.questions.length - 1 : this.current - 1;
    }
  },
  created: function() {
    fetch('/fragen.json').then(res => {
      if(res.ok) {
        res.json().then(questions => {
          this.questions = questions;
        });
      }
    });
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
