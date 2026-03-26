<?php

namespace App\Http\Controllers;

use App\Models\Patient;
use Illuminate\Http\Request;

class ControllerPatient extends Controller
{
    // Méthode pour afficher la liste des patients
    public function index()
    {
        // Récupérer tous les patients
        $patients = Patient::all(); // ou vous pouvez ajouter un orderBy si nécessaire

        // Passer les patients à la vue 'index'
        return view('patients.index', compact('patients'));
    }

    // Méthode pour afficher le formulaire de création
    public function create()
    {
        return view('patients.create'); // Utilisez patients.create pour accéder à create.blade.php
    }

    // Méthode pour stocker un nouveau patient
    public function store(Request $request)
    {
        // Validation des données envoyées par le formulaire
        $validatedData = $request->validate([
            'name' => 'required|string|max:255',
            'prenom' => 'required|string|max:255',
            'date_of_birth' => 'required|date',
        ]);

        // Création du nouveau patient
        Patient::create($validatedData);

        // Redirection vers la liste des patients avec un message de succès
        return redirect()->route('patients.index')->with('success', 'patients ajouté avec succès');
    }

    // Méthode pour afficher un patient spécifique
    public function view($id)
    {
        $patient = Patient::with('incidents')->findOrFail($id); // Charge le patient et ses incidents.
        return view('patients.view', compact('patient'));
    }


}
