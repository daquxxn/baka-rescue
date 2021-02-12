using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MusicDebug : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        AudioManager.Instance.PlayMusic("MUSICA");
        AudioManager.Instance.MusicTranstition("MUSICB", 5);
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
