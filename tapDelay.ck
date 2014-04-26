
// Sound chain
adc => Delay d => d => dac;
0.6 => d.gain;
1::second => d.max; // allocate memory
500::ms => d.delay;
// the event 
KBHit kb;
Event trigger;

// Inicializa variables
// 500.0 => float lapsAvrg; // inicializa el promedio por si no hay taps 
500.0 => float lapTime;

// crea un array para sacar el promedio de los taps
float laps[4];




while ( true )
{
	// mide el tiempo
	now => time wait;

	// espera la llegada de un evento
	kb => now;	
	kb.getchar() => int number;
	
	// Check for letter t for tap (ascii 116)
 
	if (number == 116)
	{
		now => time lap;
		// => d.delay();
		
		((60 * 1000)/((lap-wait)/ms)) => float bpmTap;

		// captura el tiempo entre tap y tap
		(lap-wait)/ms => float lapTime;

		// print
		<<< "BPM:", bpmTap, ":: Delay ::", lapTime >>>;
	}
	else
	{
		<<< "Tap on key t for tap tempo" >>>;	
	}
	400 => lapTime;
	lapTime => float lapTime1;
	(lapTime1 + lapTime)/2 => float lapTime2;
	(lapTime2 + lapTime1 + lapTime)/3 => float lapTime3;
	(lapTime3 + lapTime2 + lapTime1 + lapTime)/4 => float lapsAvrg;
	<<<  "Promedio ->", lapsAvrg >>>;
	
}
