using System.Collections;
using System.Collections.Generic;

using UnityEngine;

public class Collectible : MonoBehaviour
{
    Collider _coll;
    [SerializeField] private Score _score = null;

    // Start is called before the first frame update
    void Start()
    {
        _coll = GetComponent<Collider>();
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    //si on tire sur le collectible; avec eau ou feu : +1 au "score"

    private void OnTriggerEnter(Collider other)
    {
        if(other.gameObject.layer == 13)
        {
            _score.ScoreColl++;
           // Debug.Log(_score);
            _coll.enabled = false;
        }
    }
}
