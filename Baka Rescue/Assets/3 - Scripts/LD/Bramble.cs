using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Bramble : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    private void OnCollisionEnter(Collision collision)
    {
        Debug.Log("Back 2 ckeckpoint");
        //Renvoyer le perso qui a touché la ronce au checkpoint le plus proche
    }
}
