# RateAll
Filmes • Séries • Músicas • Animes • Jogos — tudo em um só app

---

## Visão Geral
RateAll é um aplicativo que reúne dados de cinco categorias de entretenimento:
filmes, séries, músicas, animes e jogos.

O app mostrará o que está em alta na semana, permitirá filtros salvos,
exibirá detalhes e avaliações, e oferecerá login com perfil e interação social.

Status: Planejamento inicial

---

## Fluxo Geral do Aplicativo
```
Splash Screen
 └─ verifica estado do usuário
     ├─ novo usuário → onboarding → login
     ├─ não autenticado → login
     └─ autenticado → dashboard

Dashboard
 ├─ Filmes
 ├─ Séries
 ├─ Animes
 ├─ Jogos
 └─ Músicas
      └─ Tela de detalhes → avaliar / favoritar
```

---

## Estrutura de Telas
Splash → Onboarding → Login → Dashboard  
Dashboard contém:
- Modal de Filtros  
- Tela de Detalhes  
- Tela de Perfil  
- Perfil do Amigo  

---

## Filtros por Categoria
| Categoria | Filtros principais |
|------------|-------------------|
| Filmes | Gênero, Ano, Classificação, Ordenar, Idioma |
| Séries | Gênero, Ano, Status, Classificação, Ordenar |
| Animes | Gênero, Tipo, Ano, Score, Ordenar |
| Jogos | Gênero, Plataforma, Ano, Rating, Ordenar |
| Músicas | Gênero, Ano, Popularidade, Idioma, Ordenar |

---

## Tecnologias 
- Mobile: SwiftUI 
- Banco de dados: Firebase  
- APIs externas: TMDB, Spotify, IGDB, Jikan  
- Autenticação: Apple / Google 

---

## Licença
MIT
