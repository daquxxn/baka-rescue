using System.Collections;
using System.Collections.Generic;
using UnityEngine;

using UnityEngine.UI;
using TMPro;

public class Score : MonoBehaviour
{
    [SerializeField] private TextMeshProUGUI _scoreText = null;

    private int _score = 0;
    public int ScoreColl
    {
        get
        {
            return _score;
        }
        set
        {
            _score = value;
        }
    }
       

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        _scoreText.text = "" + _score;
    }
}
