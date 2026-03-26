<?php

namespace App\Http\Controllers;

use App\Models\Incident;
use App\Models\Patient;
use Illuminate\Http\Request;

class ControllerIncident extends Controller
{
    // Méthode pour afficher le formulaire de création d'incident
    public function create()
    {
        $patients = Patient::all(); // Récupérer tous les patients
        return view('incidents.view', compact('patients')); // Affiche la vue avec les patients
    }

    // Méthode pour enregistrer l’incident
    public function store(Request $request)
    {
        // Validation des champs du formulaire
        $validatedData = $request->validate([
            'patient_id' => 'required|exists:patients,id',
            'description' => 'required|string',
            'severity' => 'required|integer',
            'date' => 'required|date',
            'incident_type' => 'required|string',
        ]);

        Incident::create($validatedData);

        return redirect()->route('patients.view', $request->patient_id)
            ->with('success', 'Incident enregistré avec succès');
    }
}
