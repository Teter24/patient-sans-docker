<!-- resources/views/patients/index.blade.php -->
<form action='{{ route('patients.store') }}'
      method='POST'>
    @csrf
    <label for='name'>Nom:</label>
    <input type='text' name='name' required>
    <label for='prenom'>Prénom:</label>
    <input type='text' name='prenom'
           required>
    <label for='date_of_birth'>Date de
        Naissance:</label>
    <input type='date' name='date_of_birth'
           required>
    <button type='submit'>Ajouter
        Patient</button>

</form>
<form action="{{ route('patients.store') }}" method="POST">


</form>
