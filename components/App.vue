<template>
  <div>

    <nav class="navbar navbar-expand-sm navbar-dark">
      <router-link to="/" class="navbar-brand">
        <img src="resources/img/tardigrade.png" class="tardigrade">
      </router-link>
      <span class="spacer"></span>
      <p class="gateway">S3 Gateway</p>

      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse justify-content-end" id="navbarSupportedContent">
        <ul class="navbar-nav ">
          <li class="nav-item">
            <a href="https://documentation.tardigrade.io/how-tos/backup-on-qnap" target="blank" class="nav-link">S3 Gateway Docs</a>
          </li>
          <li class="nav-item">
            <a href="https://tardigrade.io/login/" target="blank" class="nav-link">Tardigrade Login</a>
          </li>
        </ul>
      </div>
    </nav>

    <router-view></router-view>
  </div>
</template>

<style src="./App.css"></style>
