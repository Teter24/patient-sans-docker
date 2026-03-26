<!-- resources/views/patients/index.blade.php -->
<html>
<head>
    <title>Liste des Patients</title>
    <link rel="stylesheet" href="{{ asset('css/CSS1.css') }}">
</head>
<body>
@include('create')
<h1>Liste des Patients</h1>

<table>
    <thead>
    <tr>
        <th>Nom</th>
        <th>Prénom</th>
        <th>Date de Naissance</th>
        <th>Détails</th>
    </tr>
    </thead>
    <tbody>
    @forelse ($patients as $patient)
        <tr>
            <td>{{ $patient->name }}</td>
            <td>{{ $patient->prenom }}</td>
            <td>{{ $patient->date_of_birth }}</td>
            <td><a href="{{ route('patients.view', $patient->id) }}">View Details</a></td>
        </tr>
    @empty
        <tr>
            <td colspan="3" class="empty-message">Aucun patient.</td>
        </tr>
    @endforelse
    </tbody>
</table>

</body>
</html>
