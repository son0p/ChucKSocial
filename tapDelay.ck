
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


// crea un array para sacar el promedio de los taps
float laps[4];


500.0 => float lapTime;

0 => int count;

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
		(lap-wait)/ms =>  lapTime;

		// print
		<<< "BPM:", bpmTap, ":: Delay ::", lapTime >>>;
	
	}
	else
	{
		<<< "Tap on key t for tap tempo" >>>;	
	}

	// promedio
	
	// lapTime  =>  float lapTime1;
	// (lapTime1 + lapTime) => float lapTime2;
	// (lapTime2 + lapTime1 + lapTime) => float lapTime3;
	// (lapTime3 + lapTime2 + lapTime1 + lapTime)/8 => float lapsAvrg;
	// <<<  "P	romedio ->", lapsAvrg >>>;

	// dirty average : erroneous first average
	count++;
	count % 4 => int i;
	lapTime => laps[i];
	float sum;
	if (i == 3)
	{
		for(0 => int ii; ii < laps.cap(); ii++)
		{
			sum + laps[ii] => sum;
		}
		<<<"sum", sum/4 >>>;
	}
}
