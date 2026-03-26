<?php

namespace App\Models;
use Illuminate\Database\Eloquent\Model;
use App\Models\Incident;


class Patient extends Model
{
    protected $fillable = ['name', 'prenom', 'date_of_birth', 'idOrigineSurdite',];
    protected $table = 'patients';

    public function incidents()
    {
        return $this->hasMany(Incident::class);
    }


}

