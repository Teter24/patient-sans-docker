<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ControllerPatient;
use App\Http\Controllers\ControllerIncident;

// Page d'accueil
Route::get('/', function () {
    return redirect()->route('patients.index');
});

// Route pour afficher la liste des patients
Route::get('/patients', [ControllerPatient::class, 'index'])->name('patients.index');

// Route pour afficher le formulaire de création d'un patient
Route::get('/patients/create', [ControllerPatient::class, 'create'])->name('patients.create');

// Route pour soumettre le formulaire et ajouter un nouveau patient
Route::post('/patients', [ControllerPatient::class, 'store'])->name('patients.store');

Route::get('/incidents/create', [ControllerIncident::class, 'create'])->name('incidents.create');
Route::post('/incidents', [ControllerIncident::class, 'store'])->name('incidents.store');

// Route pour afficher les détails d'un patient spécifique
Route::get('/patients/{id}', [ControllerPatient::class, 'view'])->name('patients.view');
