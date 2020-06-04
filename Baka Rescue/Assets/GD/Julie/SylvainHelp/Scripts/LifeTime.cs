using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LifeTime : MonoBehaviour
{
    private float _timeStamp = 0f;
    [SerializeField] private float _duration = 2f;

    private void Update()
    {
        _timeStamp += Time.deltaTime;
        if (_timeStamp >= _duration)
        {
            Destroy(gameObject);
        }
    }
}
