<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>@yield('title', 'Gestion des Patients et Incidents')</title>
    <link rel="stylesheet" href="{{ asset('css/CSS2.css') }}">
</head>
<body>
<header>
    <nav class="navbar">
        <ul class="nav-list">
            <li class="nav-item"><a href="{{ route('patients.index') }}" class="nav-link">Liste des Patients et Ajouter des Patients</a></li>
        </ul>
    </nav>
</header>

<main>
    <div class="container">
        @yield('content')
    </div>
</main>

<footer>
    <p>Fait par Terence Mayombo {{ date('Y') }} </p>
</footer>
</body>
</html>
