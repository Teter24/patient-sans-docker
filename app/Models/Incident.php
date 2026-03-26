<?php

namespace App\Models;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Incident extends Model
{
    use HasFactory;

    protected $table = 'incidents';
    protected $fillable = ['patient_id', 'description', 'severity', 'date'];

    public function patient()
    {
        return $this->belongsTo(Patient::class);
    }
}
