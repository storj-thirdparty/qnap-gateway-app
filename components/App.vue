<template>
  <div>
    <nav>
      <div class="screen">
        <router-link to="/">
          <img src="../resources/img/tardigrade.png" class="tardigrade">
        </router-link>

        <span class="spacer"></span>
        <p class="gateway">S3 Gateway</p>

        <a href="https://documentation.tardigrade.io/how-tos/backup-on-qnap" target="blank" class="docs">S3 Gateway Docs</a>
        <a href="https://tardigrade.io/login/" class="login" target="blank">Tardigrade Login</a>
      </div>
    </nav>

    <router-view></router-view>
  </div>
</template>

<style src="../resources/css/App.css"></style>
