# A very simple flashcards quiz SPA

This is a quiz web application that consists of just HTML/JS/CSS and served from
a primitive web server. All quizzes are stored in a JSON file. Each quiz
consists of one or more questions presented as flashcards for users to learn and
remember. Perfect for learning vocabulary, bible verses or for challenging
your colleagues' technical skills.

# Installation

You'll need [Vue CLI](https://cli.vuejs.org/):

```
npm install -g @vue/cli
```

Then just run `npm run serve` and you're up and running. Edit
[qas.json](src/assets/qas.json) to add a new quiz or remove/edit the existing
ones.

When you're ready to deploy your quiz to a web server, run `npm run build` and
copy the resulting files from `dist/` to the web server's root.
