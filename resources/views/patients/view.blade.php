
<!-- resources/views/patients/view.blade.php -->

@extends('layouts.app')

@section('content')
    <h1>Détails du Patient</h1>

    <div>
        <h2>{{ $patient->name }} {{ $patient->prenom }}</h2>
        <p>Date de naissance : {{ $patient->date_of_birth }}</p>
        <p>Identifiant d'origine de surdité : {{ $patient->idOrigineSurdite }}</p>
    </div>

    <h2>Incidents associés</h2>
    @if ($patient->incidents->isEmpty())
        <p>Aucun incident enregistré pour ce patient.</p>
    @else
        <ul>
            @foreach ($patient->incidents as $incident)
                <li>
                    <strong>Description :</strong> {{ $incident->description }}<br>
                    <strong>Niveau de gravité :</strong> {{ $incident->severity }}<br>
                    <strong>Date :</strong> {{ $incident->date }}
                </li>
            @endforeach
        </ul>
    @endif

    <h2>Enregistrer un nouvel incident</h2>
    <form action="{{ route('incidents.store') }}" method="POST">
        @csrf
        <label for="patient_id">Patient:</label>
        <select name="patient_id" required>
            <option value="{{ $patient->id }}">{{ $patient->name }}</option>
        </select>
        <label for="description">Description:</label>
        <textarea name="description" required></textarea>
        <label for="severity">Niveau de gravité:</label>
        <select name="severity" required>
            <option value="1">Faible</option>
            <option value="2">Moyen</option>
            <option value="3">Élevé</option>
        </select>

        <label for="incident_type">Type d'incident:</label>
        <select name="incident_type" required>
            <option value="accident_travail">Accident de travail</option>
            <option value="problems_sante">Problèmes de santé</option>
            <option value="incidents_securite">Incidents de sécurité</option>
            <option value="incidents_environnementaux">Incidents environnementaux</option>
            <option value="incidents_techniques">Incidents techniques</option>
            <option value="incidents_psychosociaux">Incidents psychosociaux</option>
            <option value="autre">Autre</option>
        </select>

        <label for="date">Date de l'incident:</label>
        <input type="date" name="date" required>
        <button type="submit">Enregistrer Incident</button>
    </form>
@endsection
