using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class Collectible : MonoBehaviour
{
    [SerializeField] private TextMeshProUGUI _scoreText = null;
    public int _score = 0;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        _scoreText.text = "" + _score;
    }

    //si on tire sur le collectible; avec eau ou feu : +1 au "score"

    private void OnTriggerEnter(Collider other)
    {
        if(other.gameObject.layer == 13)
        {
            _score += 1;
            //Destroy(gameObject);
        }
    }
}
